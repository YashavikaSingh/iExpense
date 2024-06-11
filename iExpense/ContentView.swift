//
//  ContentView.swift
//  iExpense
//
//  Created by Yashavika Singh on 11.06.24.
//

import SwiftUI

struct ExpenseItem: Identifiable{
    let id = UUID()
    let name: String
    let amount: Double
    let type: String
}

@Observable
class Expenses{
    var items = [ExpenseItem]()
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    var body: some View {
     
        NavigationStack{
            List{
                ForEach(expenses.items)
                {
                    item in  Text(item.name)
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus"){
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense, content: {
                AddView(expenses: expenses)
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
