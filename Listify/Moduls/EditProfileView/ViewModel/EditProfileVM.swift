//
//  EditProfileVM.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 13.06.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class EditProfileVM: ObservableObject {
    @Published var user: User? = nil
    @Published var selectedPhoto: UIImage? = nil
    @Published var profilePhoto: URL? = nil
    @Published var name: String = ""
    @Published var birthday: String = ""
    @Published var location: String = ""
    
    @Published var errorMessage:String = ""
        
    init() {}
    
    func deleteUser() {
        let auth = Auth.auth()
        
        auth.currentUser?.delete { [weak self] error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                self?.errorMessage = "delete_account"
            }
        }
    }
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .getDocument { [weak self] snapshot, error in
                guard let data = snapshot?.data(), error == nil else { return }
                DispatchQueue.main.async {
                    self?.user = User(id: data["id"] as? String ?? "",
                                      profilePhoto:  data["profilePhoto"] as? URL ?? nil,
                                      name: data["name"] as? String ?? "",
                                      email: data["email"] as? String ?? "",
                                      birthday: data["birthday"] as? String ?? "",
                                      location: data["location"] as? String ?? "",
                                      joined: data["joined"] as? TimeInterval ?? 0)
                    if let profilePhotoString = data["profilePhoto"] as? String, let profilePhotoURL = URL(string: profilePhotoString) {
                        self?.profilePhoto = profilePhotoURL
                    }else {
                        self?.profilePhoto = nil
                    }
                    self?.name = data["name"] as? String ?? ""
                    self?.birthday = data["birthday"] as? String ?? ""
                    self?.location = data["location"] as? String ?? ""
                }
            }
    }
    
    
    
    func editProfileData() {
        guard let user = user else { return }
        loadImage { [weak self] url in
            var url: URL?
            if let imageUrl = url {
                url = imageUrl
            } else {
                url = self?.profilePhoto
            }
            
            let editedUser = User(id: user.id,
                                  profilePhoto: url,
                                  name: self?.name ?? user.name,
                                  email: user.email,
                                  birthday: self?.birthday,
                                  location: self?.location,
                                  joined: user.joined)
            
            let firestore = Firestore.firestore()
            let documentRef = firestore.collection("users").document(user.id)
            documentRef.setData(editedUser.asDictionary(), merge: true)
        }
    }
    
    
    
    func loadImage(completion: @escaping (URL?) -> Void) {
        guard let selectedImage = selectedPhoto,
              let imageData = selectedImage.jpegData(compressionQuality: 0.8) else {
            completion(nil)
            return
        }
        let imageUUID = UUID().uuidString
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("profilePhotos/\(imageUUID).jpg")
        imageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Image upload error: \(error.localizedDescription)")
                completion(nil)
            } else {
                imageRef.downloadURL { url, error in
                    if let error = error {
                        print("Download URL error: \(error.localizedDescription)")
                        completion(nil)
                    } else if let downloadURL = url {
                        completion(downloadURL)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    }
}
