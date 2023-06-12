//
//  RegisterView.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import SwiftUI

struct RegisterView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""

    var body: some View {
        VStack {
            //Header
            HeaderView(title: "Register",
                        subTitle: "Start Organizing Listify",
                       angle: -15,
                       backgrundColor: .teal)
            Form {
                TextField("Full Name", text: $name)
                    .autocorrectionDisabled()
                TextField("Email Adress", text: $email)
                    .autocapitalization(.none)
                SecureField("Password", text: $password)
                TLButton(title: "Create Account", backgroundColor: Color.teal, action: {
                    //Registration Action
                })
            }
            
            Spacer()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
