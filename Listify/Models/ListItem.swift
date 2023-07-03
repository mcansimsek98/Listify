//
//  ListItem.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import Foundation

struct ListItem: Codable, Identifiable {
    let id: String
    let title: String
    let body: String
    let dueDate: TimeInterval
    let createDate: TimeInterval
    let categoryName: String
    var isDone: Bool
    
    mutating func setDone( _ state: Bool) {
        isDone = state
    }
}
