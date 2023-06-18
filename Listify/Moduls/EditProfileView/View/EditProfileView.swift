//
//  EditProfileView.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 13.06.2023.
//

import SwiftUI
import URLImage

struct EditProfileView: View {
    @StateObject var viewModel = EditProfileVM()
    @Binding var editProfilePresented: Bool
    @State private var isShowingImagePicker = false
    @State private var isShowingDeleteAlert = false
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray5)
            VStack {
                ZStack {
                    CustomHeaderView(title: "Edit Profile")
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                editProfilePresented = false
                            } label: {
                                Image(systemName: "clear")
                                    .aspectRatio(contentMode: .fill)
                                    .foregroundColor(.white)
                                    .frame(width: 24, height: 24)
                            }
                            .padding(.trailing, 12)
                            .padding(.top, 30)
                    }
                }
                ZStack {
                    ScrollView {
                        VStack {
                            if let user = viewModel.user {
                                profile(user: user)
                            }else {
                                Text(LocalizedStringKey("loading_profile"))
                                Spacer()
                            }
                        }
                        Spacer()
                    }
                    .scrollIndicators(.never)
                }
            }
            .onAppear {
                viewModel.fetchUser()
            }
            .alert(isPresented: $isShowingDeleteAlert) {
                Alert(
                    title: Text(LocalizedStringKey("delete_account")),
                    message: Text(LocalizedStringKey("delete_account_confirmation")),
                    primaryButton: .destructive(Text(LocalizedStringKey("delete"))) {
                        viewModel.deleteUser()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    @ViewBuilder
    func profile(user: User) -> some View {
        // Avatar
        VStack {
            if let image = viewModel.selectedPhoto {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 125, height: 125)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.teal, lineWidth: 2))
            } else {
                if let imageUrl = viewModel.profilePhoto {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125, height: 125)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.teal, lineWidth: 2))
                    } placeholder: {
                        Image(systemName: "person.fill.badge.plus")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(Color.teal)
                            .frame(width: 125, height: 125)
                    }
                } else {
                    Image(systemName: "person.fill.badge.plus")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(Color.teal)
                        .frame(width: 125, height: 125)
                }
            }
            
            Button(LocalizedStringKey("choose_photo")) {
                isShowingImagePicker = true
            }
            .foregroundColor(.gray)
            .font(.system(size: 12))
            .padding()
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(image: $viewModel.selectedPhoto)
            }
        }
        .padding(.top, 12)
        
        // Info
        
        VStack(alignment: .leading) {
            HStack {
                Text(LocalizedStringKey("title"))
                    .bold()
                TextField("", text: $viewModel.name)
            }
            .padding()
            HStack {
                Text("Email:")
                    .bold()
                Text(user.email)
                    .foregroundColor(.green)
            }
            .padding()
            
            HStack {
                DatePickerStringView(birthday: $viewModel.birthday)
            }
            .padding()
            HStack {
                Text(LocalizedStringKey("location"))
                    .bold()
                TextField("Istanbul, Türkiye", text: $viewModel.location)
            }
            .padding()
            
        }
        .padding()
        
        TLButton(title: LocalizedStringKey("save"), backgroundColor: .teal) {
            viewModel.editProfileData()
            editProfilePresented = false
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: 35)
        .padding(.bottom)
        
        Button(LocalizedStringKey("delete_account")) {
            isShowingDeleteAlert = true
        }
        .font(.system(size: 12))
        .foregroundColor(.red)
        Spacer()
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(editProfilePresented: Binding(get: {
            return true
        }, set: { _, _ in
            
        }))
    }
}
