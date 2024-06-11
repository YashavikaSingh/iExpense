//
//  ContentView.swift
//  iExpense
//
//  Created by Yashavika Singh on 11.06.24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable{
    var id = UUID()
    let name: String
    let amount: Double
    let type: String
}

@Observable
class Expenses{
    var items = [ExpenseItem](){
        didSet{
            if let encoded = try? JSONEncoder() .encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items ")
            }
        }
    }
    init()
    {
        if let savedItems = UserDefaults.standard.data(forKey: "Items")
        {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems)
            {
                items = decodedItems
                return
            }
            
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    var body: some View {
     
        NavigationStack{
            List{

                Section("Personal items"){
                    ForEach(expenses.items.filter{$0.type == "Personal"})
                    {
                        item in
                            HStack{
                                VStack(alignment: .leading){
                                    Text(item.name).font(.headline)
                                 

                                }
                                Spacer()
                                VStack{
                                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                }
                                                                
                            }
                            .foregroundStyle(item.amount>=1000 ? .red : item.amount>100 ? .orange : item.amount>10 ? .yellow : .green)
                        
                        } .onDelete(perform: removeItem)

                }
                
                Section("Business items"){
                    ForEach(expenses.items.filter{$0.type == "Business"})
                    {
                        item in
                            HStack{
                                VStack(alignment: .leading){
                                    Text(item.name).font(.headline)
                                    Text(item.type)

                                }
                                Spacer()
                                VStack{
                                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                }
                                                                
                            }
                            .foregroundStyle(item.amount>=1000 ? .red : item.amount>100 ? .orange : item.amount>10 ? .yellow : .green)
                        
                        } .onDelete(perform: removeItem)
                }
                
                
                
                

                    
                
               
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus"){
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense, content: {
                AddView(expenses: expenses )
            })
            
        }
    }

    func removeItem(at offsets: IndexSet)
    {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
