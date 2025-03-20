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
                        .font(.custom("HelveticaNeue-Bold", size: 96)) //<--- Kailie: custom font imported, must be a misconfig as it is not loading properly.
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
                                .font(.custom("Menlo-Bold", size: 16))
                                .frame(width: 300, height: 50)
                                .background(Color.clear)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(#colorLiteral(red: 0.1701194298, green: 0.1297623498, blue: 0.2721540133, alpha: 1)), lineWidth: 2))
                                .shadow(color: Color(#colorLiteral(red: 0.13401145, green: 0.1061868557, blue: 0.2262137172, alpha: 0.7275455298)), radius: 4, x: -3, y: -3)
                                .foregroundColor(.white)
                        }

                        NavigationLink(destination: RegisterView()) {
                            Text("Sign Up")
                                .font(.custom("Menlo-Bold", size: 16))
                                .frame(width: 300, height: 50)
                                .background(Color.clear)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(#colorLiteral(red: 0.1701194298, green: 0.1297623498, blue: 0.2721540133, alpha: 1)), lineWidth: 2))
                                .shadow(color: Color(#colorLiteral(red: 0.13401145, green: 0.1061868557, blue: 0.2262137172, alpha: 0.7275455298)), radius: 4, x: -3, y: -3)
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
