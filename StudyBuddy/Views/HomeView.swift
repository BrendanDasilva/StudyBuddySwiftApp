//
//  HomeView.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-04.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack { // ✅ Enables navigation
            ZStack {
                Color(hex: "8AACEA").edgesIgnoringSafeArea(.all)
                VStack(spacing: 30) {
                    Text("STUDY\nBUDDY")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    VStack(spacing: 15) {
                        NavigationLink(destination: LoginView()) {
                            Text("Login")
                                .frame(width: 200, height: 50)
                                .background(Color.clear)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.purple, lineWidth: 2))
                                .foregroundColor(.white)
                        }

                        NavigationLink(destination: RegisterView()) {
                            Text("Sign Up")
                                .frame(width: 200, height: 50)
                                .background(Color.clear)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.purple, lineWidth: 2))
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    Group {
        HomeView()
    }
}
