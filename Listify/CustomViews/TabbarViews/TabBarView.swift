//
//  TabBarView.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 17.06.2023.
//

import SwiftUI

struct TabBarView: View {
    private let userId: String
    @State var selectedIndex = 0
    @State var isPresented = false
    
    let icons = [
    "house",
    "plus",
    "person.circle"
    ]
    
    init(userId: String) {
        self.userId = userId
    }
    
    
    var body: some View {
        ZStack {
            Color.clear
            accountView
        }
    }
    
    
    @ViewBuilder
    var accountView: some View {
        VStack {
            ZStack {
                Spacer().fullScreenCover(isPresented: $isPresented) {
                    CreateNewItemView( newItemPresented: $isPresented)
                }
                
                switch selectedIndex {
                case 0:
                    ListView(userId: self.userId)
                case 1:
                    EmptyView()
                case 2:
                    ProfileView()
                default:
                    EmptyView()
                }
            }
            HStack {
                ForEach(0..<3, id: \.self) { num in
                    Spacer()
                    Button {
                        if num == 1 {
                            self.isPresented.toggle()
                        } else {
                            self.selectedIndex = num
                        }
                    } label: {
                        if num == 1 {
                            Image(systemName: icons[num])
                                .font(.system(size: 25,
                                              weight: .regular,
                                              design: .default))
                                .foregroundColor(.white)
                                .frame(width: 60,height: 60)
                                .background(Color.secondary.gradient)
                                .shadow(color: Color.black, radius: 10)
                                .cornerRadius(30)
                        }
                        else {
                            Image(systemName: icons[num])
                                .font(.system(size: 25,
                                              weight: .medium,
                                              design: .default))
                                .foregroundColor(selectedIndex == num ? Color(UIColor.black) : Color(UIColor.systemMint))
                        }
                    }
                    Spacer()
                }
            }
            .frame(height: 70)
            .background(Color.gray.gradient)
            .cornerRadius(80)
            .shadow(radius: 20)
            .padding(.trailing, 12)
            .padding(.leading, 12)
        }
        .background(Color.clear)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(userId: "")
    }
}

