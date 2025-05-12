//
//  UserModel.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 7/5/2025.
//

import Foundation

enum UserRole: String, Codable {
    case user
    case admin
}

struct User: Codable, Identifiable {
    var id: Int
    var username: String
    var password: String
    var role: UserRole
}
