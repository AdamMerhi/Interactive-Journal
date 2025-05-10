//
//  RegistrationView.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 7/5/2025.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject private var regModel = RegistrationModel()

    var body: some View {
        VStack {
            TextField("Username", text: $regModel.username)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Password", text: $regModel.password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            //Toggle("Admin", isOn: $regModel.isAdmin)
               // .padding()

            if !regModel.message.isEmpty {
                Text(regModel.message)
                    .foregroundColor(.red)
            }

            Button(action: regModel.register) {
                Text("Register")
                    .frame(width: 200, height: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    RegistrationView()
}
