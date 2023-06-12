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
            HeaderView(title: "Register",
                        subTitle: "Start Organizing Listify",
                       angle: -15,
                       backgrundColor: .teal)
            Form {
                if !viewModel.errorMessage.trimmingCharacters(in: .whitespaces).isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .font(.system(size: 12))
                }
                TextField("Full Name", text: $viewModel.name)
                    .autocorrectionDisabled()
                TextField("Email Adress", text: $viewModel.email)
                    .autocapitalization(.none)
                SecureField("Password", text: $viewModel.password)
                TLButton(title: "Create Account", backgroundColor: Color.teal, action: {
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
