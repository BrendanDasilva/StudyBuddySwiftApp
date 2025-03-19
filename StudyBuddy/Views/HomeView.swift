//
//  HomeView.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-04.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "8AACEA").edgesIgnoringSafeArea(.all)
                VStack(spacing: 30) {
                    Text("STUDY\nBUDDY")
                        .font(.custom("Anybody SemiBold", size: 96))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .shadow(color: Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)), radius: 8, x: 0, y: 8)
                        .multilineTextAlignment(.center)
 //--------------- Kailie : tying to reduce alignment between "STUDY and "BUDDY" with .padding(.zero) or .linespacing(0)
//                              >> tried placing into a separate HSTACK and VSTACK (will address later)
//                    Text("BUDDY")
//                        .padding(.zero)
//                        .lineLimit(nil)
//                        .font(.custom("Anybody SemiBold", size: 96))
//                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
//                        .shadow(color: Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha:                     1)), radius: 8, x: 0, y: 8)
//                        .multilineTextAlignment(.center)

                    VStack(spacing: 15) {
                        NavigationLink(destination: LoginView()) {
                            Text("Login")
                                .frame(width: 300, height: 50)
                                .background(Color.clear)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(#colorLiteral(red: 0.3562943339, green: 0.2727283835, blue: 0.5644717216, alpha: 1)), lineWidth: 2))
                                .shadow(color: Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), radius: 4, x: 0, y: 4)
                                .foregroundColor(.white)
                        }

                        NavigationLink(destination: RegisterView()) {
                            Text("Sign Up")
                                .frame(width: 300, height: 50)
                                .background(Color.clear)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(#colorLiteral(red: 0.3562943339, green: 0.2727283835, blue: 0.5644717216, alpha: 1)), lineWidth: 2))
                                .shadow(color: Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), radius: 4, x: 0, y: 4)
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
