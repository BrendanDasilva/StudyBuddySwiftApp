//
//  StudyBuddyApp.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-04.
//  Edited by Jessica Lee on 3-19-2025. Changed opening view to Login screen
//

import SwiftUI

@main
struct StudyBuddyApp: App {
    let persistenceController = CoreDataManager.shared

    // Check if user is logged in
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                HomeView() // Redirects to HomeView if user is logged in
            } else {
                LoginView() // Show LoginView by default
            }
        }
    }
}

