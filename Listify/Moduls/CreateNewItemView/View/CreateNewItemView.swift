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
            Text("New Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 70)
            
            Form {
                // Title
                TextField("Name", text: $viewModel.title)
                // Due Date
                DatePicker.init("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                // Button
                TLButton(title: "Save",
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
                Alert(title: Text("Error"),
                      message: Text("Please feel in all fields and select due date that is today or newer."))
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
