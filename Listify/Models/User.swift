//
//  User.swift
//  Listify
//
//  Created by Mehmet Can Şimşek on 12.06.2023.
//

import Foundation

struct User: Codable {
    let id: String
    let profilePhoto: URL?
    let name: String
    let email: String
    let birthday: String?
    let location: String?
    let joined: TimeInterval
}
