//
//  Category.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 14.06.2023.
//

import SwiftUI

struct CategoryModel: Hashable {
    let id: Int
    let title: String
    let image: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(image)
    }

    static func ==(lhs: CategoryModel, rhs: CategoryModel) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.image == rhs.image
    }
}
