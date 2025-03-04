//
//  GroupTile.swift
//  StudyBuddy
//
import SwiftUI

struct GroupTile: View {
    var groupName: String
    var studyTopics: [String]
    var members: Int
    var isOpen: Bool

    var body: some View {
        HStack {
            Image(systemName: "person.3.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .padding(.leading, 10)

            VStack(alignment: .leading) {
                Text(groupName)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(studyTopics.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            Spacer()

            HStack {
                Image(systemName: "person.fill")
                    .foregroundColor(.white.opacity(0.8))
                Text("\(members)")
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding(.trailing, 10)

            Text(isOpen ? "Open" : "Private")
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(isOpen ? Color.green : Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.trailing, 10)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.blue.opacity(0.8))
        .cornerRadius(10)
    }
}
