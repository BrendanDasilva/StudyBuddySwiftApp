//
//  StudyAppsView.swift
//  StudyBuddy
//

import SwiftUI

struct StudyAppsView: View {
    let studyApps = [
        "Courses", "Scheduler", "Pomodoro Timer", "Flash Cards", "To-Do List", "Notes"
    ]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack {
            Text("Study Apps")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 20)

            // grid layout for study apps
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(studyApps, id: \.self) { app in
                    StudyAppGridButton(title: app)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 30)

            Spacer()
        }
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
    }
}


