//
//  ProfileView.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileVM()
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray5)
            VStack(alignment: .center) {
                CustomHeaderView(title: LocalizedStringKey("profile"))
                VStack {
                    if let user = viewModel.user {
                        profile(user: user)
                    }else {
                        Text(LocalizedStringKey("loading_profile"))
                    }
                }
                Spacer()
            }
            .onAppear {
                viewModel.fetchUser()
            }
            .padding(.top, -40)
        }
    }
    
    @ViewBuilder
    func profile(user: User) -> some View {
        // Avatar
        VStack {
            if let imageUrl = viewModel.user?.profilePhoto {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.teal, lineWidth: 2))
                } placeholder: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.teal)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.teal, lineWidth: 2))
                }
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.teal)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.teal, lineWidth: 2))
            }
            Button(LocalizedStringKey("edit_profile")) {
                viewModel.showingEditView = true
            }
            .bold()
            .font(.system(size: 12))
            .tint(.teal)
            .fullScreenCover(isPresented: $viewModel.showingEditView) {
                EditProfileView(editProfilePresented: $viewModel.showingEditView)
                    .onDisappear {
                        viewModel.fetchUser()
                    }
            }
        }
        .padding()
        // Info
        VStack(alignment: .leading) {
            HStack {
                Text(LocalizedStringKey("title"))
                    .bold()
                Text(user.name)
            }
            .padding(.bottom, 10)
            HStack {
                Text(LocalizedStringKey("email"))
                    .bold()
                Text(user.email)
            }
            .padding(.bottom, 10)

            if let birthday = viewModel.user?.birthday,
               !birthday.trimmingCharacters(in: .whitespaces).isEmpty {
                HStack {
                    Text(LocalizedStringKey("birthday"))
                        .bold()
                    Text(birthday)
                }
                .padding(.bottom, 10)
            }
            
            if let location = viewModel.user?.location,
               !location.trimmingCharacters(in: .whitespaces).isEmpty {
                HStack {
                    Text(LocalizedStringKey("location"))
                        .bold()
                    Text(location)
                }
                .padding(.bottom, 10)
            }
            
            HStack {
                Text(LocalizedStringKey("member_since"))
                    .bold()
                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
            .padding(.bottom, 10)

        }
        .padding(.top, 30)
        .padding(.leading, -40)
        Spacer()
        
        Button(LocalizedStringKey("log_out")) {
            viewModel.logOut()
        }
        
        .tint(.red)
        .padding(.bottom, 20)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
