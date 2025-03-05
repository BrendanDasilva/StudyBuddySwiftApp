//
//  StudyAppsView.swift
//  StudyBuddy
//

import SwiftUI

struct StudyAppsView: View {
    let studyApps: [(String, AnyView)] = [
        ("Courses", AnyView(CoursesApp())),
        ("Scheduler", AnyView(SchedulerApp())),
        ("Pomodoro Timer", AnyView(PomodoroTimerApp())),
        ("Flash Cards", AnyView(FlashCardsApp())),
        ("To-Do List", AnyView(ToDoApp())),
        ("Notes", AnyView(NotesApp()))
    ]

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack {
            Text("Study Apps")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 20)

            // ✅ Grid Layout with Navigation
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(studyApps, id: \.0) { app in
                    StudyAppGridButton(title: app.0, destination: app.1)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 30)

            Spacer()
        }
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
    }
}


