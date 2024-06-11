//
//  AddView.swift
//  iExpense
//
//  Created by Yashavika Singh on 11.06.24.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var expenses:   Expenses
    let types = ["Personal", "Business"]
    

     

    var body: some View {
        return NavigationStack{
            Form{
                TextField("Name", text: $name)
                Picker("Type", selection: $type)
                {
                    ForEach(types, id: \.self)
                    {
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: "USD ")).keyboardType(.decimalPad )
                
               
                
            }
            .navigationTitle("Add new expense")
            .toolbar{
                Button("Save")
                {
                    let createdItem = ExpenseItem(name: name, amount: amount, type: type)
                    expenses.items.append(createdItem)
                    dismiss()
                }

                    

            
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
 
