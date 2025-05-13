//
//  Interactive_JournalApp.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 23/4/2025.
//

import SwiftUI

@main
struct Interactive_JournalApp: App {
    
    @StateObject var loginModel = LoginModel()

var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loginModel)
        }
    }
}
