//
//  CreateNewItemVM.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class CreateNewItemVM: ObservableObject {
    @Published var title: String = ""
    @Published var body: String = ""
    @Published var dueDate = Date()
    @Published var showAlert: Bool = false
    
    @Published var selectedCategoryIndex: Int = 0
    @Published var categories: [String] = [
        "personal",
        "work",
        "education",
        "trip",
        "shopping",
        "events",
        "home",
        "health"
    ]
    
    init() {}
    
    func saved() {
        guard canSave else {
            return
        }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let newId = UUID().uuidString
        let newItem = ListItem(id: newId,
                               title: title,
                               body: body,
                               dueDate: dueDate.timeIntervalSince1970,
                               createDate: Date().timeIntervalSince1970,
                               categoryName: categories[selectedCategoryIndex],
                               isDone: false)
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(newId)
            .setData(newItem.asDictionary())
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        guard !body.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard dueDate >= Date().addingTimeInterval(-86400) else {
             return false
        }
        
        return true
    }
}
