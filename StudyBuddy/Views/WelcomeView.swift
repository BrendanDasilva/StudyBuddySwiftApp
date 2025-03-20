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
                            .font(.custom("HelveticaNeue-Bold", size: 36))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .shadow(color: Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), radius: 4, x: 0, y: 4)
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

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

