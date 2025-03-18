//
//  JoinGroupView.swift
//  StudyBuddy
//

import SwiftUI
import CoreData

struct JoinGroupView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var groupCode: String = ""
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StudyGroup.createdAt, ascending: false)],
        predicate: NSPredicate(format: "isOpen == YES AND isMember == NO"),
        animation: .default
    ) private var openGroups: FetchedResults<StudyGroup>

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Join a Study Group")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 5) {
                    Text("Enter Study Group Code")
                        .foregroundColor(.white.opacity(0.8))
                    HStack {
                        TextField("Enter code", text: $groupCode)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: joinGroup) {
                            Text("Join")
                                .padding(.vertical, 8)
                                .padding(.horizontal, 15)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)

                Text("Open Study Groups")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .padding(.horizontal)

                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(openGroups) { group in
                            GroupTile(group: group, isJoined: false)
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding()
            .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
        }
    }
    
    private func joinGroup() {
        guard !groupCode.isEmpty else { return }
        
        let request: NSFetchRequest<StudyGroup> = StudyGroup.fetchRequest()
        request.predicate = NSPredicate(format: "code == %@", groupCode)
        
        do {
            let results = try viewContext.fetch(request)
            if let group = results.first {
                group.isMember = true
                group.members += 1
                try viewContext.save()
                groupCode = ""
            }
        } catch {
            print("Error joining group: \(error.localizedDescription)")
        }
    }
}

