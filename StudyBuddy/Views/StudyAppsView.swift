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
            Text("STUDY APPS")
                .padding(.top, 80)
                .font(.custom("Anybody", size: 40))
                .fontWeight(.bold)
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .shadow(color: Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)), radius: 4, x: 0, y: 4)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.bottom, 20)

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
struct StudyAppsView_Preview: PreviewProvider {
    static var previews: some View {
        StudyAppsView()
    }
}

