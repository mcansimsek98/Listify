//
//  CreateNewItemView.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import SwiftUI

struct CreateNewItemView: View {
    @StateObject var viewModel = CreateNewItemVM()
    @Binding var newItemPresented: Bool
    
    var body: some View {
        VStack {
            Text(LocalizedStringKey("new_plan"))
                .font(.system(size: 32))
                .bold()
                .padding(.top, 70)
            
            Form {
                // Title
                TextField(LocalizedStringKey("enter_plan"), text: $viewModel.title)
                // Due Date
                DatePicker.init(LocalizedStringKey("due_date"), selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                // Button
                TLButton(title: LocalizedStringKey("save"),
                         backgroundColor: .brown
                ) {
                    if viewModel.canSave {
                        viewModel.saved()
                        newItemPresented = false
                    }else {
                        viewModel.showAlert = true
                    }
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text(LocalizedStringKey("error")),
                      message: Text(LocalizedStringKey("fill_in_all")))
            }
        }
    }
}

struct CreateNewItemView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewItemView(newItemPresented: Binding(get: {
            return true
        }, set: { _, _ in
            
        }))
    }
}
