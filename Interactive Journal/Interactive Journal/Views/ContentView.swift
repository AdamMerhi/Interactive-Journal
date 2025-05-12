//
//  ContentView.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 23/4/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    isLoggedIn = true
                }) {
                    Text("Go to Login")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink("Go to Registration", destination: RegistrationView())
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                LoginView()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
