//
//  HeaderView.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import SwiftUI

struct HeaderView: View {
    let title: LocalizedStringKey
    let subTitle: LocalizedStringKey
    let angle: Double
    let backgrundColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(backgrundColor)
                .rotationEffect(Angle(degrees: angle))
            VStack {
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
                    .bold()
                Text(subTitle)
                    .font(.system(size: 25))
                    .foregroundColor(Color.white)
            }
            .padding(.top, 85)
        }
        .frame(width: UIScreen.main.bounds.width * 3, height: 350)
        .offset(y: -150)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Title", subTitle: "Subtitle", angle: 15, backgrundColor: .blue)
    }
}


struct CustomHeaderView: View {
    var title: LocalizedStringKey
    
    var body: some View {
        ZStack {
            Color.gray
                .frame(height: UIScreen.main.bounds.size.height * 0.146)
                .clipShape(
                    RoundedCorners(corners: [.bottomLeft, .bottomRight], radius: 18)
                )
            
            Text(title)
                .font(.custom("Noteworthy", size: 40))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .offset(y: 20)
                .padding(.bottom, 15)
        }
        .edgesIgnoringSafeArea(.top)
    }
}
