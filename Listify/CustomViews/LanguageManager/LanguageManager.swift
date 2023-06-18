//
//  LanguageManager.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 14.06.2023.
//

import SwiftUI

class LanguageManager: ObservableObject {
    @Published var currentLanguage = Locale.current.languageCode ?? "en" {
        didSet {
            UserDefaults.standard.set([currentLanguage], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            Bundle.main.load()
        }
    }
}
