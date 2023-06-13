//
//  LoginVM.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import Foundation
import FirebaseAuth
import SwiftUI

class LoginVM: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login() {
        guard validate() else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            if error != nil {
                self?.errorMessage = "not_found_user"
            }
        }
        self.objectWillChange.send()
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "left_blank_email_or_password"
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "enter_valid_email"
            return false
        }
        return true
    }
}
