//
//  ProfileVM.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileVM: ObservableObject {
    @Published var user: User? = nil
    @Published var showingEditView: Bool = false
    
    init() {}
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .getDocument { [weak self] snapshot, error in
                guard let data = snapshot?.data(), error == nil else { return }
                DispatchQueue.main.async {
                    let profilePhoto: URL?
                    if let profilePhotoString = data["profilePhoto"] as? String, let profilePhotoURL = URL(string: profilePhotoString) {
                        profilePhoto = profilePhotoURL
                    }else {
                        profilePhoto = nil
                    }
                    self?.user = User(id: data["id"] as? String ?? "",
                                      profilePhoto: profilePhoto,
                                      name: data["name"] as? String ?? "",
                                      email: data["email"] as? String ?? "",
                                      birthday: data["birthday"] as? String ?? "",
                                      location: data["location"] as? String ?? "",
                                      joined: data["joined"] as? TimeInterval ?? 0)
                }
            }
    }
    func logOut() {
        do {
            try Auth.auth().signOut()
        }catch {
            print(error)
        }
    }
}
