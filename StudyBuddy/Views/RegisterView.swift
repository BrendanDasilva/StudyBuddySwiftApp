//
//  RegisterView.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-04.
//  Edited by Jessica Lee 03-19-2025 - Added Success Popup and Auto Navigation
//

import SwiftUI

struct RegisterView: View {
    @Binding var navigateBackToLogin: Bool  // Binding to go back to LoginView

    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var showSuccessAlert = false  // Controls alert display

    let backendURL = "http://192.168.85.128:5000/api/auth/register"  // Update with your actual backend IP

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
                        .autocapitalization(.none)

                    Text("Email").foregroundColor(.white)
                    TextField("user@domain.com", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)

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
                    navigateBackToLogin = false  // Return to LoginView
                }
                .frame(width: 200, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding(.top, 10)

                Spacer()
            }
        }
        .alert("Registration Successful", isPresented: $showSuccessAlert) {  // Show alert on success
            Button("OK") {
                navigateBackToLogin = false  // Automatically navigate back
            }
        } message: {
            Text("You have successfully registered. Redirecting to login...")
        }
    }

    func registerUser() {
        print("Register button clicked!")  // Debugging: Check if function is triggered

        guard let url = URL(string: backendURL) else {
            print("Invalid URL")
            errorMessage = "Invalid URL"
            return
        }

        let body: [String: Any] = [
            "username": username,
            "email": email,
            "password": password
        ]

        print("Sending request with body: \(body)")  // Debugging: Check request data

        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            print("Failed to encode JSON")
            errorMessage = "Failed to encode data"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Network error: \(error.localizedDescription)")
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    print("No data received")
                    self.errorMessage = "No data received."
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")

                    if httpResponse.statusCode == 201 {
                        print("Registration successful! Showing alert.")
                        self.showSuccessAlert = true  // Show success alert
                    } else {
                        print("Registration failed with status: \(httpResponse.statusCode)")
                        self.errorMessage = "Registration failed. Try again."
                    }
                }
            }
        }.resume()
    }
}

#Preview {
    RegisterView(navigateBackToLogin: .constant(false))  // For preview purposes
}
