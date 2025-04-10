//
//  ContentView.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-04.
//             Kailie Field [SN] : 100627702
//             Jessica Lee
//             Lucas Caridi

import SwiftUI


struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }

    var body: some View {
        NavigationStack {
            TabView {
                WelcomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }

                AccountView()
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                        Text("Account")
                    }
            }
        }
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
