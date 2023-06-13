//
//  RegisterVM.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

class RegisterVM : ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    init() {}
    
    func createAccount() {
        guard validate() else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, errorMessage in
            if let errorMessage = errorMessage {
                self?.errorMessage = "use_by_another_account"
            }
            guard let userId = result?.user.uid else { return }
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id,
                           profilePhoto: nil,
                           name: name,
                           email: email,
                           birthday: nil,
                           location: nil,
                           joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
                !email.trimmingCharacters(in: .whitespaces).isEmpty,
                !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "error_name_email_password"
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "enter_valid_email"
            return false
        }
        guard password.count >= 6 else {
            errorMessage = "error_password"
            return false
        }
        return true
    }
}
