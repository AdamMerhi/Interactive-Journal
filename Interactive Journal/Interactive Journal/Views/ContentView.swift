//
//  ContentView.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 23/4/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var loginModel = LoginModel()

    var body: some View {
        NavigationStack {
            VStack {
                if loginModel.isLoggedIn {
                    LandingView(isLoggedIn: $loginModel.isLoggedIn, userName: loginModel.currentUsername)
                        .environmentObject(loginModel)
                } else {
                    VStack {
                        NavigationLink("Go to Login", destination:
                                        LoginView(isLoggedIn: $loginModel.isLoggedIn)
                            .environmentObject(loginModel)
                        )
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                        NavigationLink("Go to Register", destination: RegistrationView())
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
