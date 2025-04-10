//
//  RegisterView.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-04.
//

import SwiftUI

struct RegisterView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var registrationError: String?

    var body: some View {
        ZStack {
            Color(hex: "8AACEA").edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("STUDY\nBUDDY")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Username").foregroundColor(.white)
                    TextField("user1234", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Email").foregroundColor(.white)
                    TextField("user@domain.com", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Password").foregroundColor(.white)
                    SecureField("******", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal, 30)
                
                Button("Register") {
                    registerUser()
                }
                .frame(width: 200, height: 50)
                .background(Color.purple)
                .cornerRadius(10)
                .foregroundColor(.white)

                if let registrationError = registrationError {
                    Text(registrationError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top, -10)
                }

                Spacer()
            }
        }
    }

    private func registerUser() {
        guard let url = NetworkHelper.getBackendURL(endpoint: "/api/users/register") else {
            self.registrationError = "Could not find IP address"
            return
        }

        let payload = [
            "username": username,
            "email": email,
            "password": password
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: payload) else {
            self.registrationError = "Invalid registration data"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.registrationError = error.localizedDescription
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.registrationError = "No response from server"
                }
                return
            }

            if httpResponse.statusCode == 200 {
                // Store login info in UserDefaults
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.set(self.email, forKey: "userEmail")
                
                DispatchQueue.main.async {
                    // Auto-login and navigate to Home
                    // Navigate to the login screen with auto-login enabled
                    // Consider setting `isLoggedIn` to true here
                }
            } else {
                DispatchQueue.main.async {
                    self.registrationError = "Failed to register user"
                }
            }
        }.resume()
    }
}
