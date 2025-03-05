//
//  SchedulerApp.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-04.
//


import SwiftUI

struct SchedulerApp: View {
    var body: some View {
        VStack {
            Text("Scheduler App")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
    }
}
