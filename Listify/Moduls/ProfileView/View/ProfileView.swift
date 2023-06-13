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
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                }else {
                    Text(LocalizedStringKey("loading_profile"))
                }
            }
            .navigationTitle(LocalizedStringKey("profile"))
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(LocalizedStringKey("log_out")) {
                        viewModel.logOut()
                    }
                    .tint(.red)
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(LocalizedStringKey("edit")) {
                        viewModel.showingEditView = true
                    }
                    .bold()
                    .tint(.teal)
                }
            }
            .fullScreenCover(isPresented: $viewModel.showingEditView) {
                EditProfileView(editProfilePresented: $viewModel.showingEditView)
                    .onDisappear {
                        viewModel.fetchUser()
                    }
            }
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
    
    @ViewBuilder
    func profile(user: User) -> some View {
        // Avatar
        if let imageUrl = viewModel.user?.profilePhoto {
            AsyncImage(url: imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 125, height: 125)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.teal, lineWidth: 2))
            } placeholder: {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.teal)
                    .frame(width: 125, height: 125)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.teal, lineWidth: 2))
            }
        } else {
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.teal)
                .frame(width: 125, height: 125)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.teal, lineWidth: 2))
        }
        // Info
        VStack(alignment: .leading) {
            HStack {
                Text(LocalizedStringKey("title"))
                    .bold()
                Text(user.name)
            }
            .padding()
            HStack {
                Text(LocalizedStringKey("email"))
                    .bold()
                Text(user.email)
            }
            .padding()
            
            if let birthday = viewModel.user?.birthday,
               !birthday.trimmingCharacters(in: .whitespaces).isEmpty {
                HStack {
                    Text(LocalizedStringKey("birthday"))
                        .bold()
                    Text(birthday)
                }
                .padding()
            }
            
            if let location = viewModel.user?.location,
               !location.trimmingCharacters(in: .whitespaces).isEmpty {
                HStack {
                    Text(LocalizedStringKey("location"))
                        .bold()
                    Text(location)
                }
                .padding()
            }
            
            HStack {
                Text(LocalizedStringKey("member_since"))
                    .bold()
                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
            .padding()
            
        }
        .padding()
        Spacer()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
