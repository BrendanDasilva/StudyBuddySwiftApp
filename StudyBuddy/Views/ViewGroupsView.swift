//
//  ViewGroupsView.swift
//  StudyBuddy
//

import SwiftUI

struct ViewGroupsView: View {
    let myGroups = [
        ("AI Enthusiasts", ["Machine Learning", "Deep Learning"], 7, true),
        ("Web Dev Crew", ["React", "Node.js"], 10, false),
        ("Study Ninjas", ["Calculus", "Statistics"], 6, true),
        ("Data Science Hub", ["Python", "Data Analysis"], 12, false)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Your Study Groups")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(myGroups, id: \.0) { group in
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


