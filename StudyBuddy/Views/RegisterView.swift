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
                
                Button("Register") {}
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
        RegisterView()
    }
}
