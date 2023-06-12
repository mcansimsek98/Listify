//
//  ListVM.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import Foundation
import FirebaseFirestore

class ListVM: ObservableObject {
    @Published var showingNewItemView: Bool = false
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    func deleteItem(id: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
}
