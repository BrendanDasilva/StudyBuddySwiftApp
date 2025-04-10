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
        ZStack {
            Color(hex: "8AACEA").edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                Text("STUDY\nBUDDY")
                    .padding(.top, 180)
                    .font(.custom("HelveticaNeue-Bold", size: 96))
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .shadow(color: Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)), radius: 8, x: 0, y: -8)
                    .multilineTextAlignment(.center)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Email").foregroundColor(.white)
                        .font(.custom("Menlo", size: 16))
                    TextField("user@domain.com", text: $email)
                        .font(.custom("Menlo", size: 16))
                        .foregroundColor(Color(#colorLiteral(red: 0.3499752283, green: 0.3499752283, blue: 0.3499751687, alpha: 1)))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Password").foregroundColor(.white)
                        .font(.custom("Menlo", size: 16))
                    SecureField("******", text: $password)
                        .font(.custom("Menlo", size: 16))
                        .foregroundColor(Color(#colorLiteral(red: 0.3482678346, green: 0.3482678346, blue: 0.3482678346, alpha: 1)))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Toggle("Remember Me", isOn: $rememberMe)
                        .font(.custom("Menlo", size: 16))
                        .foregroundColor(.white)
                    
                }
                .padding(.horizontal, 30)
                
                Button("Login") {}
                    .font(.custom("Menlo", size: 16))
                    .frame(width: 200, height: 50)
                    .background(Color(#colorLiteral(red: 0.534640789, green: 0.4167757928, blue: 0.865655005, alpha: 1)))
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(#colorLiteral(red: 0.4175539088, green: 0.3225862927, blue: 0.697378627, alpha: 0.6353218129)), lineWidth: 2))
                    .shadow(color: Color(#colorLiteral(red: 0.1370129638, green: 0.1044493588, blue: 0.2434654624, alpha: 0.5061568709)), radius: 2, x: 0, y: 2)
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
