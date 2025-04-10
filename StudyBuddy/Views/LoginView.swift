//
//  LoginView.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-05.
//

import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool

    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var loginError: String?

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "8AACEA").edgesIgnoringSafeArea(.all)
                VStack(spacing: 30) {
                    Text("STUDY\nBUDDY")
                        .padding(.top, 180)
                        .font(.custom("HelveticaNeue-Bold", size: 96))
                        .foregroundColor(Color.white)
                        .shadow(color: Color.gray, radius: 8, x: 0, y: -8)
                        .multilineTextAlignment(.center)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Email").foregroundColor(.white)
                            .font(.custom("Menlo", size: 16))
                        TextField("user@domain.com", text: $email)
                            .font(.custom("Menlo", size: 16))
                            .foregroundColor(.gray)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Text("Password").foregroundColor(.white)
                            .font(.custom("Menlo", size: 16))
                        SecureField("******", text: $password)
                            .font(.custom("Menlo", size: 16))
                            .foregroundColor(.gray)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Toggle("Remember Me", isOn: $rememberMe)
                            .font(.custom("Menlo", size: 16))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 30)

                    Button("Login") {
                        loginUser()
                    }
                    .font(.custom("Menlo", size: 16))
                    .frame(width: 200, height: 50)
                    .background(Color.purple)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.purple.opacity(0.6), lineWidth: 2))
                    .shadow(color: Color.purple.opacity(0.4), radius: 2, x: 0, y: 2)
                    .foregroundColor(.white)

                    if let loginError = loginError {
                        Text(loginError)
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.top, -10)
                    }

                    Spacer()

                    // Sign Up Link at the bottom
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.white)
                            .font(.custom("Menlo", size: 14))

                        NavigationLink(destination: RegisterView()) {
                            Text("Sign Up")
                                .foregroundColor(.white)
                                .underline()
                                .font(.custom("Menlo-Bold", size: 14))
                        }
                    }
                    .padding(.bottom, 40)
                }
            }
        }
        .onAppear {
            if let isLoggedIn = UserDefaults.standard.value(forKey: "isLoggedIn") as? Bool, isLoggedIn {
                self.isLoggedIn = true
            }
        }
    }

    private func loginUser() {
        guard let url = NetworkHelper.getBackendURL(endpoint: "/api/users/login") else {
            self.loginError = "Could not find IP address"
            return
        }

        let payload = [
            "username": email,
            "password": password
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: payload) else {
            self.loginError = "Invalid login data"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.loginError = error.localizedDescription
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.loginError = "No response from server"
                }
                return
            }

            if httpResponse.statusCode == 200 {
                // Save login status
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.set(self.email, forKey: "userEmail")
                
                DispatchQueue.main.async {
                    self.isLoggedIn = true
                }
            } else {
                DispatchQueue.main.async {
                    self.loginError = "Invalid username or password"
                }
            }
        }.resume()
    }
}
