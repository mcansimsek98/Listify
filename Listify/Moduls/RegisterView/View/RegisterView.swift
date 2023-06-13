//
//  RegisterView.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterVM()
    
    var body: some View {
        VStack {
            //Header
            HeaderView(title: LocalizedStringKey("register"),
                        subTitle: LocalizedStringKey("star_organizing"),
                       angle: -15,
                       backgrundColor: .teal)
            Form {
                if !viewModel.errorMessage.trimmingCharacters(in: .whitespaces).isEmpty {
                    Text(LocalizedStringKey(viewModel.errorMessage))
                        .foregroundColor(.red)
                        .font(.system(size: 12))
                }
                TextField(LocalizedStringKey("name"), text: $viewModel.name)
                    .autocorrectionDisabled()
                TextField(LocalizedStringKey("e_posta"), text: $viewModel.email)
                    .autocapitalization(.none)
                SecureField(LocalizedStringKey("password"), text: $viewModel.password)
                TLButton(title: LocalizedStringKey("create_account"), backgroundColor: Color.teal, action: {
                    viewModel.createAccount()
                })
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton())
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
