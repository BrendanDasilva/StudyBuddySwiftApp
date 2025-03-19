//
//  LoginView.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-05.
//  Edited by Jessica Lee 03-19-2025 - Added Backend Logic
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var navigateToRegister = false  //State variable for navigation

    @AppStorage("isLoggedIn") private var isLoggedIn = false

    let backendURL = "http://192.168.85.128:5000" // Update to your IP to use

    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "8AACEA").edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Text("STUDY\nBUDDY")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Email").foregroundColor(.white)
                        TextField("user@domain.com", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Text("Password").foregroundColor(.white)
                        SecureField("******", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.horizontal, 30)

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                    Button("Login") {
                        loginUser()
                    }
                    .frame(width: 200, height: 50)
                    .background(Color.purple)
                    .cornerRadius(10)
                    .foregroundColor(.white)

                    NavigationLink(destination: RegisterView(navigateBackToLogin: $navigateToRegister)) {
                        Text("Sign Up")
                            .frame(width: 200, height: 50)
                            .background(Color.clear)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.purple, lineWidth: 2))
                            .foregroundColor(.white)
                    }

                    Spacer()
                }
            }
        }
    }

    func loginUser() {
        guard let url = URL(string: "\(backendURL)/api/auth/login") else { return }

        let body: [String: Any] = [
            "email": email,
            "password": password
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self.errorMessage = "No data received."
                    return
                }

                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let token = jsonResponse["token"] as? String {

                        UserDefaults.standard.set(token, forKey: "authToken")
                        self.isLoggedIn = true  // Redirects to HomeView
                    } else {
                        self.errorMessage = "Invalid response format."
                    }
                } else {
                    self.errorMessage = "Invalid email or password."
                }
            }
        }.resume()
    }
}
