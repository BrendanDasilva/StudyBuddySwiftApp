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

                Text(text) //<--- kailie: consider using a label to maintain size of text with label
                    .font(.custom("Menlo-Bold", size: 15))
                    .foregroundColor(.white)
                    .padding()

                Spacer()
            }
            .frame(height: 100)
            .background(Color(#colorLiteral(red: 0.534640789, green: 0.4167757928, blue: 0.865655005, alpha: 1)))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(#colorLiteral(red: 0.1701194298, green: 0.1297623498, blue: 0.2721540133, alpha: 1)), lineWidth: 2))
            .shadow(color: Color(#colorLiteral(red: 0.13401145, green: 0.1061868557, blue: 0.2262137172, alpha: 0.7275455298)), radius: 4, x: -4, y: -3)
            .cornerRadius(10)
        }
    }
}

