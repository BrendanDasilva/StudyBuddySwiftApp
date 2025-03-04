//
//  StudyBuddyButton.swift
//  StudyBuddy
//

import SwiftUI

struct StudyBuddyButton<Destination: View>: View {
    var imageName: String
    var text: String
    var destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .padding(.leading, 15)

                Spacer()

                Text(text)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()

                Spacer()
            }
            .frame(height: 100)
            .background(Color.blue)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.purple, lineWidth: 5))
            .cornerRadius(10)
        }
    }
}

