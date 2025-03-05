//
//  LoginView.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-05.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false
    
    var body: some View {
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
                    
                    Toggle("Remember Me", isOn: $rememberMe)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 30)
                
                Button("Login") {}
                    .frame(width: 200, height: 50)
                    .background(Color.purple)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
    }
}


#Preview {
    Group {
        LoginView()
    }
}
