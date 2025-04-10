//
//  GroupTileNavigationView.swift
//  StudyBuddy
//
//  Created by jessica lee on 2025-04-10.
//

import SwiftUI
import CoreData

struct GroupTileNavigationView: View {
    var group: StudyGroup

    var body: some View {
        NavigationLink(destination: StudyAppsView(groupName: group.name ?? "Study Apps")) {
            GroupTile(group: group, isJoined: true)
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

