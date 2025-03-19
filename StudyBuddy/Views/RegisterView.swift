//
//  RegisterView.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-04.
//  Edited by Jessica Lee 03-19-2025 - Added Backend Logic
//

import SwiftUI

struct RegisterView: View {
    @Binding var navigateBackToLogin: Bool  // Ensure this exists

    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""

    let backendURL = "http://192.168.85.128:5000" // Update to your IP to use

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

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                Button("Register") {
                    registerUser()
                }
                .frame(width: 200, height: 50)
                .background(Color.purple)
                .cornerRadius(10)
                .foregroundColor(.white)

                Button("Back to Login") {
                    navigateBackToLogin = false  // Ensure this sets the binding
                }
                .frame(width: 200, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding(.top, 10)

                Spacer()
            }
        }
    }

    func registerUser() {
        guard let url = URL(string: "\(backendURL)/api/auth/register") else { return }

        let body: [String: Any] = [
            "username": username,
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

                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                    navigateBackToLogin = false  //Return to LoginView on success
                } else {
                    self.errorMessage = "Registration failed. Try again."
                }
            }
        }.resume()
    }
}
