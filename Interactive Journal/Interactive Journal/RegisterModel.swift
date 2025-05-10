//
//  RegisterModel.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 10/5/2025.
//

import Foundation
import SwiftUI

@MainActor
class RegistrationModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var isAdmin = false
    @Published var message = ""

    private var userDefaultsManager = UserDefaultsManager()

    private var users: [User] {
        userDefaultsManager.loadUsers()
    }

    func register() {
        let userID = (users.last?.id ?? 0) + 1
        let role: UserRole = isAdmin ? .admin : .user

        let newUser = User(id: userID, username: username, password: password, role: role)

        var updatedUsers = users
        updatedUsers.append(newUser)

        userDefaultsManager.saveUsers(users: updatedUsers)

        message = "Registration successful!"
    }
}
