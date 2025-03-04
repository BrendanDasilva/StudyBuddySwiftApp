//
//  AccountView.swift
//  StudyBuddy
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        VStack {
            // Profile Section
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .padding(.top, 20)

                Text("User123456")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text("user@example.com")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding()

            // Settings & Preferences
            List {
                Section(header: Text("Settings").foregroundColor(.white)) {
                    Button(action: {
                        print("Change Password Tapped")
                    }) {
                        Label("Change Password", systemImage: "key.fill")
                    }
                    Button(action: {
                        print("Notification Preferences Tapped")
                    }) {
                        Label("Notification Preferences", systemImage: "bell.fill")
                    }
                    Button(action: {
                        print("Theme Selection Tapped")
                    }) {
                        Label("Theme Selection", systemImage: "paintbrush.fill")
                    }
                }

                // App Data Management
                Section(header: Text("App Data").foregroundColor(.white)) {
                    Button(action: {
                        print("View Study Groups Tapped")
                    }) {
                        Label("View Saved Study Groups", systemImage: "folder.fill")
                    }
                    Button(action: {
                        print("Clear Cache Tapped")
                    }) {
                        Label("Clear Cached Data", systemImage: "trash.fill")
                    }
                }

                // Support & About
                Section(header: Text("Support & About").foregroundColor(.white)) {
                    Button(action: {
                        print("Contact Support Tapped")
                    }) {
                        Label("Contact Support", systemImage: "envelope.fill")
                    }
                    Button(action: {
                        print("Terms & Conditions Tapped")
                    }) {
                        Label("Terms & Conditions", systemImage: "doc.text.fill")
                    }
                }

                Section {
                    Button(action: {
                        print("Log Out Tapped")
                    }) {
                        Label("Log Out", systemImage: "arrow.backward.circle.fill")
                            .foregroundColor(.red)
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
    }
}
