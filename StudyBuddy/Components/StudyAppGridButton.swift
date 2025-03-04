//
//  StudyAppGridButton.swift
//  StudyBuddy
//


import SwiftUI

struct StudyAppGridButton: View {
    var title: String

    var body: some View {
        Button(action: {
            print("\(title) tapped")
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 140, height: 140)
                .background(Color.blue)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.purple, lineWidth: 5))
                .cornerRadius(10)
        }
    }
}

