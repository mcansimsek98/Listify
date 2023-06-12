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
                           subTitle: "Achieve Your Goals",
                           angle: 15,
                           backgrundColor: .gray)
                //LoginForm
                Form {
                    if !viewModel.errorMessage.trimmingCharacters(in: .whitespaces).isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .font(.system(size: 12))
                    }
                    TextField("Email Adress", text: $viewModel.email)
                        .autocapitalization(.none)
                    SecureField("Password", text: $viewModel.password)
                    TLButton(title: "Log In", backgroundColor: Color.gray, action: {
                        viewModel.login()
                    })
                }
                .offset(y: -50)
                //Create Account
                VStack {
                    Text("New around here?")
                    NavigationLink("Create An Account") {
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
