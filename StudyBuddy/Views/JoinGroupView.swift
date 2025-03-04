//
//  JoinGroupView.swift
//  StudyBuddy
//

import SwiftUI

struct JoinGroupView: View {
    @State private var groupCode: String = ""
    
    let openGroups = [
        ("Study Squad", ["Math", "Physics"], 5, true),
        ("Code Masters", ["Swift", "Kotlin"], 12, false),
        ("Night Owls", ["History", "English"], 8, false),
        ("Data Gurus", ["AI", "ML"], 19, false),
        ("Study Guys", ["Math", "Physics"], 8, true),
        ("Math Masters", ["Swift", "Kotlin"], 11, false),
        ("Night Nerds", ["History", "English"], 5, true),
        ("Data Gals", ["AI", "ML"], 5, false)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Join a Study Group")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)

            // input field for study group code
            VStack(alignment: .leading, spacing: 5) {
                Text("Enter Study Group Code")
                    .foregroundColor(.white.opacity(0.8))
                HStack {
                    TextField("Enter code", text: $groupCode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        print("Joining group with code: \(groupCode)")
                    }) {
                        Text("Join")
                            .padding(.vertical, 8)
                            .padding(.horizontal, 15)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }

            // list of available study groups
            Text("Open Study Groups")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top, 10)

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(openGroups, id: \.0) { group in
                        GroupTile(groupName: group.0, studyTopics: group.1, members: group.2, isOpen: group.3)
                    }
                }
            }

            Spacer()
        }
        .padding()
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
    }
}

