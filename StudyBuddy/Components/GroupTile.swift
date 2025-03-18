//
//  GroupTile.swift
//  StudyBuddy
//

import SwiftUI
import CoreData

struct GroupTile: View {
    @Environment(\.managedObjectContext) private var viewContext
    var group: StudyGroup
    var isJoined: Bool
    
    var body: some View {
        NavigationLink {
            GroupDetailView(
                group: group,
                buttonTitle: isJoined ? "Leave Group" : "Join Group",
                buttonAction: isJoined ? leaveGroup : joinGroup
            )
        } label: {
            HStack {
                Image(systemName: "person.3.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .padding(.leading, 10)

                VStack(alignment: .leading) {
                    Text(group.name ?? "Unnamed Group")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text((group.topics as? [String] ?? []).joined(separator: ", "))
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                Spacer()

                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.white.opacity(0.8))
                    Text("\(group.members)")
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.trailing, 10)

                Text(isJoined ? "Joined" : "Joinable")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(isJoined ? Color.green : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.trailing, 10)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue.opacity(0.8))
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func joinGroup() {
        group.isMember = true
        group.members += 1
        saveContext()
    }
    
    private func leaveGroup() {
        group.isMember = false
        group.members = max(0, group.members - 1)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
}
