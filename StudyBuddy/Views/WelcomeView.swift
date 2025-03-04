//
//  WelcomeView.swift
//  StudyBuddy
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "8AACEA")
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Welcome,\nUser123456")
                            .font(.title)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .lineSpacing(5)
                        Spacer()
                    }
                    .padding(.top, 50)
                    .padding(.leading, 25)

                    VStack(spacing: 15) {
                        StudyBuddyButton(imageName: "person", text: "Individual Study Session", destination: StudyAppsView())
                        StudyBuddyButton(imageName: "person.2", text: "Join a Study Group", destination: JoinGroupView())
                        StudyBuddyButton(imageName: "list.bullet", text: "View Your Study Groups", destination: ViewGroupsView())
                        StudyBuddyButton(imageName: "plus", text: "Create a Study Group", destination: CreateGroupView())
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 25)

                    Spacer(minLength: 5)
                }
            }
        }
    }
}

