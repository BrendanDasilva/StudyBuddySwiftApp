//
//  StudyAppGridButton.swift
//  StudyBuddy
//


import SwiftUI

struct StudyAppGridButton: View {
    var title: String
    var destination: AnyView

    var body: some View {
        NavigationLink(destination: destination) {
            VStack {
                Text(title)
//                    .font(.custom("Inter Regular", size: 20))
//                    .font(.custom("Anybody SemiBold", size: 20))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .frame(width: 140, height: 140)
            .background(Color(#colorLiteral(red: 0.4053930044, green: 0.3153994977, blue: 0.6412855983, alpha: 1)))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(#colorLiteral(red: 0.3270430565, green: 0.255667299, blue: 0.5171721578, alpha: 1)), lineWidth: 3))
            .cornerRadius(10)
        }
    }
}

