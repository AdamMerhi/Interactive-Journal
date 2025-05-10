//
//  LoginPageView.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 7/5/2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginModel = LoginModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Username", text: $loginModel.username)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)

                SecureField("Password", text: $loginModel.password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if !loginModel.errorMessage.isEmpty {
                    Text(loginModel.errorMessage)
                        .foregroundColor(.red)
                }

                Button(action: loginModel.login) {
                    Text("Login")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                NavigationLink(
                    destination: loginModel.isAdmin ? AnyView(AdminDashboardView()) : AnyView(LandingView(userName: loginModel.currentUsername)),
                    isActive: $loginModel.isLoggedIn
                ) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
