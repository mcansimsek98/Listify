//
//  LoginView.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginVM()
    
    var body: some View {
        NavigationView {
            VStack {
                //Header
                HeaderView(title: "Listify",
                           subTitle: LocalizedStringKey("achieve_your_goals"),
                           angle: 15,
                           backgrundColor: .gray)
                //LoginForm
                Form {
                    if !viewModel.errorMessage.trimmingCharacters(in: .whitespaces).isEmpty {
                        Text(LocalizedStringKey(viewModel.errorMessage))
                            .foregroundColor(.red)
                            .font(.system(size: 12))
                    }
                    TextField(LocalizedStringKey("e_posta"), text: $viewModel.email)
                        .autocapitalization(.none)
                    SecureField(LocalizedStringKey("password"), text: $viewModel.password)
                    TLButton(title: LocalizedStringKey("log_in"), backgroundColor: Color.gray, action: {
                        viewModel.login()
                    })
                }
                .offset(y: -50)
                //Create Account
                VStack {
                    Text(LocalizedStringKey("new_around"))
                    NavigationLink(LocalizedStringKey("create_account")) {
                        RegisterView()
                    }
                }
                .padding(.bottom, 50)
                
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
