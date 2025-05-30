//
//  LoginModel.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 10/5/2025.
//

import Foundation
import SwiftUI

@MainActor
class LoginModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isLoggedIn = false
    @Published var isAdmin = false
    @Published var currentUsername = ""
    @Published var currentUserId: Int?  = nil

    private var userDefaultsManager = UserDefaultsManager()
    private var users: [User] { userDefaultsManager.loadUsers() }

    func login() {
        if let user = users.first(where: { $0.username == username && $0.password == password}) {
            isAdmin = user.role == .admin
            isLoggedIn = true
            currentUsername = user.username
            currentUserId = user.id

        } else{
            errorMessage = "Invalid username or password"
        }
    }
    
    func logout() {
        isLoggedIn = false
        username = ""
        password = ""
        currentUsername = ""
        isAdmin = false
    }

}

