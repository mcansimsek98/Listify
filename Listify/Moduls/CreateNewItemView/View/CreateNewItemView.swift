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
        ZStack {
            Color(UIColor.systemGray5)
            VStack {
                ZStack {
                    CustomHeaderView(title: "new_plan")
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            newItemPresented = false
                        } label: {
                            Image(systemName: "clear")
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(.white)
                                .frame(width: 24, height: 24)
                        }
                        .padding(.trailing, 12)
                        .padding(.top, 30)
                }
                }
                Form {
                    Section {
                        // Category
                        Picker(selection: $viewModel.selectedCategoryIndex, label: Text(LocalizedStringKey("category"))) {
                            ForEach(viewModel.categories.indices, id: \.self) { index in
                                Text(LocalizedStringKey(viewModel.categories[index]))
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    Section {
                        // Title
                        TextField(LocalizedStringKey("enter_title"), text: $viewModel.title)
                            .font(.system(size: 15))
                        
                        // Body
                        PlaceholderTextEditor(placeholder: LocalizedStringKey("enter_plan"), text: $viewModel.body)
                            .frame(height: 250)
                    }
                    
                    Section {
                        // Due Date
                        DatePicker(LocalizedStringKey("due_date"), selection: $viewModel.dueDate, in: Date()..., displayedComponents: [.date])
                            .datePickerStyle(.compact)
                            .padding(4)
                        // Button
                        Text(LocalizedStringKey("create_message"))
                            .font(.system(size: 11))
                            .foregroundColor(.red)
                            .padding(.top, 8)
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
                }
                .scrollIndicators(.never)
                .padding(.top, -6)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text(LocalizedStringKey("error")),
                      message: Text(LocalizedStringKey("fill_in_all")))
            }
        }
        .edgesIgnoringSafeArea(.all)
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
