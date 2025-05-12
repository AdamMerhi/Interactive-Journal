//
//  Interactive_JournalApp.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 23/4/2025.
//

import SwiftUI

@main
struct Interactive_JournalApp: App {
    
    init() {
        resetUserDefaults() // ⚠️ Only during development
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    func resetUserDefaults() {
        let defaults = UserDefaults.standard
        //defaults.removeObject(forKey: "users")
        defaults.removeObject(forKey: "friendsList")
        defaults.synchronize()
    }
}
