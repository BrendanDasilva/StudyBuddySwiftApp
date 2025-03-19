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
                    .font(.custom("Menlo", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .frame(width: 140, height: 140)
            .background(Color(#colorLiteral(red: 0.5355279818, green: 0.4187251282, blue: 0.8651133492, alpha: 1))) //<---- Kailie: trying something lighter to test
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(#colorLiteral(red: 0.3058196902, green: 0.2380354702, blue: 0.4852798581, alpha: 1)), lineWidth: 2))
            .shadow(color: Color(#colorLiteral(red: 0.2552796441, green: 0.2815312526, blue: 0.4284840593, alpha: 1)), radius: 8, x: -4, y: -8)
        }
    }
}

