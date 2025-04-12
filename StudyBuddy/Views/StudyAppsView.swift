//
//  StudyApps View.swift
//  StudyBuddy
//

//
//  StudyApps View.swift
//  StudyBuddy
//

import SwiftUI

struct StudyAppsView: View {
    let groupId: String // The groupId passed from the previous view

    // List of study apps, ensure each app has its respective view properly initialized
    let studyApps: [(String, AnyView)] = [
        ("Courses", AnyView(CoursesApp())),
        ("Scheduler", AnyView(SchedulerApp())),
        ("Pomodoro Timer", AnyView(PomodoroTimerApp())),
        ("Flash Cards", AnyView(FlashCardsApp(groupId: "sample-group-id"))), // Pass groupId to the FlashCardsApp
        ("To-Do List", AnyView(ToDoApp())),
        ("Notes", AnyView(NotesApp()))
    ]
    
    // Grid layout for study apps (two columns)
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack {
            // Title section with the group name at the top
            Text("STUDY APPS")
                .padding(.top, 80)
                .font(.custom("HelveticaNeue-Bold", size: 50))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 4)
                .padding(.bottom, 20)

            Text("Group: \(groupId)")  // Display the groupId passed from the previous screen
                .font(.title2)
                .foregroundColor(.white)
                .padding(.bottom, 20)

            // Grid layout for study apps
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(studyApps, id: \.0) { app in
                    // Each app in the grid has a corresponding button and navigates to the app's view
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

struct StudyAppsView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview with a sample groupId
        StudyAppsView(groupId: "sample-group-id")
    }
}
