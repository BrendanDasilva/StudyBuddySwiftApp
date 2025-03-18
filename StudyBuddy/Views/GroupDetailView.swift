//
//  GroupDetailView.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-14.
//

//
//  GroupDetailView.swift
//  StudyBuddy
//

import SwiftUI
import CoreData

struct GroupDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    let group: StudyGroup
    let buttonTitle: String
    let buttonAction: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            // Group Info
            VStack(alignment: .leading, spacing: 15) {
                InfoRow(label: "Group Name:", value: group.name ?? "Unnamed Group")
                InfoRow(label: "Code:", value: group.code ?? "XXXXXX")
                InfoRow(label: "Members:", value: "\(group.members)")
                InfoRow(label: "Status:", value: group.isOpen ? "Open" : "Closed")
                InfoRow(label: "Created:", value: group.createdAt?.formatted() ?? "Unknown")
                
                VStack(alignment: .leading) {
                    Text("Features:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text((group.features as? [String] ?? []).joined(separator: ", "))
                }
                
                VStack(alignment: .leading) {
                    Text("Study Topics:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text((group.topics as? [String] ?? []).joined(separator: ", "))
                }
            }
            .padding()
            
            Spacer()
            
            // Action Button
            Button(action: {
                buttonAction()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text(buttonTitle)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(buttonTitle == "Leave Group" ? Color.red : Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Group Details")
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label).bold()
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
    }
}
