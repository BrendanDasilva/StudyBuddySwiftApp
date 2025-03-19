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
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .shadow(color: Color(#colorLiteral(red: 0.3432517467, green: 0.42835429, blue: 0.5897996155, alpha: 1)), radius: 8, x: 8, y: 8)

                Text("User123456")
                    .font(.custom("HeleticaNeue-Medium", size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text("user@example.com")
                    .font(.custom("Menlo", size: 18))
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
                .font(.custom("Menlo", size: 15))
                .shadow(color: Color(#colorLiteral(red: 0.5314670139, green: 0.5314670139, blue: 0.5314670139, alpha: 0.707910803)), radius: 3, x: -3, y: -3)

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
                .font(.custom("Menlo", size: 15))
                .shadow(color: Color(#colorLiteral(red: 0.5314670139, green: 0.5314670139, blue: 0.5314670139, alpha: 0.707910803)), radius: 3, x: -3, y: -3)

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
                .font(.custom("Menlo", size: 15))
                .shadow(color: Color(#colorLiteral(red: 0.5314670139, green: 0.5314670139, blue: 0.5314670139, alpha: 0.707910803)), radius: 3, x: -3, y: -3)

                Section {
                    Button(action: {
                        print("Log Out Tapped")
                    }) {
                        Label("Log Out", systemImage: "arrow.backward.circle.fill")
                            .foregroundColor(.red)
                    }
                    .font(.custom("Menlo-Bold", size: 15))
                    .shadow(color: Color(#colorLiteral(red: 0.7712476326, green: 0.179381073, blue: 0.1504877813, alpha: 0.5655008278)), radius: 3, x: -3, y: -3)
                }
            }
            .scrollContentBackground(.hidden)
        }
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
    }
}

struct AccountView_Prieview: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
