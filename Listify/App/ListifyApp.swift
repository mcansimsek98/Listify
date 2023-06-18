//
//  ListifyApp.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import SwiftUI
import Firebase
import IQKeyboardManagerSwift

@main
struct ListifyApp: App {
    @ObservedObject var languageManager = LanguageManager()

    init() {
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
    }
    var body: some Scene {
        WindowGroup {
            MainView()
                .background(Color(UIColor.systemGray5))
                .environmentObject(languageManager)
        }
    }
}
