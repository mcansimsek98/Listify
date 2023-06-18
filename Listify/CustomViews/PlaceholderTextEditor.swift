//
//  PlaceholderTextEditor.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 18.06.2023.
//

import SwiftUI

struct PlaceholderTextEditor: View {
    let placeholder: LocalizedStringKey
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(.top, 8)
                    .padding(.leading, 4)
                    .font(.system(size: 12))
            }
            
            TextEditor(text: $text)
                .foregroundColor(.primary)
                .font(.system(size: 12))
        }
    }
}
