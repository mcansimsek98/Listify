//
//  RegisterVM.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterVM : ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    init() {}
    
    func createAccount() {
        guard validate() else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, errorMessage in
            guard let userId = result?.user.uid else { return }
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id,
                           name: name,
                           email: email,
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
            errorMessage = "The Full Name, Email or Password cannot be left blank."
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Enter a valid email address"
            return false
        }
        guard password.count >= 6 else {
            errorMessage = "Your password must be 6 characters or more."
            return false
        }
        return true
    }
}
