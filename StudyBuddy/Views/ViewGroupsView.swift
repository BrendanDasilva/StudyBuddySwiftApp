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
                                    .contextMenu {
                                        Button(action: {
                                            // Action for view/edit details
                                            print("View/Edit Group Details tapped for \(group.name ?? "")")
                                        }) {
                                            Label("View/Edit Details", systemImage: "pencil")
                                        }
                                    }
                                    .background(
                                        NavigationLink(
                                            destination: StudyAppsView(group: group),
                                            label: { EmptyView() }
                                        )
                                    )
                                    .buttonStyle(PlainButtonStyle())  // To avoid the default navigation button style
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

// The GroupTile View Component (Updated to Include Menu)
struct GroupTile: View {
    var group: StudyGroup
    var isJoined: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(group.name ?? "Group Name")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("Created at: \(group.createdAt ?? Date(), formatter: DateFormatter.shortDate)")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            }

            Spacer()

            // Add the 3 vertical dots (context menu)
            Image(systemName: "ellipsis.vertical")
                .foregroundColor(.white)
                .padding(10)
                .background(Circle().fill(Color.black.opacity(0.5)))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.2)))
        .padding(.horizontal)
    }
}

// Preview
#Preview {
    ViewGroupsView()
}
