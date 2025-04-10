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
    @State private var isLoggedIn = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "8AACEA").edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Text("STUDY\nBUDDY")
                        .font(.system(size: 20, weight: .bold))
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
            .onChange(of: isLoggedIn) { loggedIn in
                if loggedIn {
                    // Navigate to home or main screen after successful registration
                    // For now, let's just navigate to the LoginView
                    // This would typically navigate to a home or dashboard screen
                }
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
                    self.registrationError = "Error: \(error.localizedDescription)"
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.registrationError = "No response from server"
                }
                return
            }

            // Check if the status code is 200 or 201 (successful registration)
            if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                DispatchQueue.main.async {
                    // Store login info in UserDefaults
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    UserDefaults.standard.set(self.email, forKey: "userEmail")

                    // Auto-login and navigate to Home (or another screen)
                    self.isLoggedIn = true  // Auto-login successful
                    self.registrationError = "Registration successful!"
                }
            } else {
                // If the response code is not 200/201, show the error from the response body
                if let data = data, let errorMessage = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        self.registrationError = "Registration failed: \(errorMessage)"
                    }
                }
            }
        }.resume()
    }
}

struct RegisterView_Preview: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
