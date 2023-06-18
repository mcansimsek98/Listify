//
//  ContentView.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainVM()
    var body: some View {
        if viewModel.isSingedIn, !viewModel.currentUserId.isEmpty {
            ZStack {
                Color(UIColor.systemGray5)
                TabBarView(userId: viewModel.currentUserId)
            }
        }else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
