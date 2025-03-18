//
//  ViewGroupsView.swift
//  StudyBuddy
//

import SwiftUI
import CoreData

struct ViewGroupsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StudyGroup.createdAt, ascending: false)],
        predicate: NSPredicate(format: "isMember == YES"),
        animation: .default
    ) private var groups: FetchedResults<StudyGroup>

    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "8AACEA").ignoresSafeArea()
                VStack(alignment: .leading, spacing: 15) {
                    Text("Your Study Groups")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal)

                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(groups) { group in
                                GroupTile(group: group, isJoined: true)
                            }
                        }
                        .padding(.horizontal)
                    }

                    Spacer()
                }
                .padding()
            }
        }
    }
}

// Preview
#Preview {
    ViewGroupsView()
}
