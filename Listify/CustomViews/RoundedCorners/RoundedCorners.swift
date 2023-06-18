//
//  RoundedCorners.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 18.06.2023.
//

import SwiftUI

struct RoundedCorners: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
