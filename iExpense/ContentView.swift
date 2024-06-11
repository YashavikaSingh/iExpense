//
//  ContentView.swift
//  iExpense
//
//  Created by Yashavika Singh on 11.06.24.
//

import SwiftUI

struct ExpenseItem{
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
    var body: some View {
     
        NavigationStack{
            List{
                ForEach(expenses.items, id: \.name)
                {
                    item in  Text(item.name)
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus"){
                    
                }
            }
            
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
