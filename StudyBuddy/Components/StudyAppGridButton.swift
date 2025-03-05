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
                    .font(.headline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .frame(width: 140, height: 140)
            .background(Color.blue)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.purple, lineWidth: 3))
            .cornerRadius(10)
        }
    }
}

