//
//  AdminDashboardView.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 7/5/2025.
//

import SwiftUI

struct AdminDashboardView: View {
    
    private var userDefaultsManager = UserDefaultsManager()
    
    // Get users from UserDefaults
    private var users: [User] {
        userDefaultsManager.loadUsers()
    }
    
    var body: some View{
        VStack{
            Text("Admin Dashboard")
                .font(.largeTitle)
                .padding()
            
            List(users){ user in
                VStack(alignment: .leading){
                    Text("Username: \(user.username)")
                    Text("Role: \(user.role.rawValue.capitalized)")
                    Text("ID: \(user.id)")
                }
            }
            .padding()
        }
        //.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AdminDashboardView()
}
