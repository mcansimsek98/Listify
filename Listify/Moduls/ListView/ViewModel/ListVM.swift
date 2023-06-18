//
//  ListVM.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import SwiftUI
import FirebaseFirestore

class ListVM: ObservableObject {
    private let userId: String
    @Published var selectedCategoryIndex: Int = 0
    
    @Published var categories: [CategoryModel] = [
        CategoryModel(id: 0, title: "all_category", image: "allCategories"),
        CategoryModel(id: 1, title: "personal", image: "personal"),
        CategoryModel(id: 2, title: "work", image: "work"),
        CategoryModel(id: 3, title: "education", image: "education"),
        CategoryModel(id: 4, title: "trip", image: "trip"),
        CategoryModel(id: 5, title: "shopping", image: "shopping"),
        CategoryModel(id: 6, title: "events", image: "events"),
        CategoryModel(id: 7, title: "home", image: "home"),
        CategoryModel(id: 8, title: "health", image: "health")
    ]
    
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
