//
//  CreateGroupView.swift
//  StudyBuddy
//

import SwiftUI
import CoreData

struct CreateGroupView: View {
    // MARK: - Core Data Properties
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - State Properties
    @State private var groupName: String = ""
    @State private var selectedFeatures: [String] = []
    @State private var studyTopics: [String] = []
    @State private var newTopic: String = ""
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    // MARK: - Constants
    let availableFeatures = ["Courses", "Scheduler", "Pomodoro Timer", "Flash Cards", "To-Do List", "Notes"]

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // MARK: - Header
            Text("Create a Study Group")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.bottom, 10)

            // MARK: - Group Name Input
            VStack(alignment: .leading, spacing: 5) {
                Text("Group Name")
                    .foregroundColor(.white.opacity(0.8))
                TextField("Study Group Name", text: $groupName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                Text("Required • 3-25 characters")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
            }

            // MARK: - Feature Selection
            VStack(alignment: .leading, spacing: 10) {
                Text("Include Features")
                    .foregroundColor(.white.opacity(0.8))
                ForEach(availableFeatures, id: \.self) { feature in
                    HStack {
                        Image(systemName: selectedFeatures.contains(feature) ? "checkmark.square.fill" : "square")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.purple)
                            .onTapGesture { toggleFeature(feature) }
                        Text(feature)
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
            }
            .padding(.vertical, 5)

            // MARK: - Study Topics Section
            VStack(alignment: .leading, spacing: 10) {
                Text("Study Topics")
                    .foregroundColor(.white.opacity(0.8))
                
                // Input Row
                HStack {
                    TextField("Add topic (e.g., Calculus)", text: $newTopic)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: addTopic) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.purple)
                    }
                }
                
                // Topics List
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(studyTopics, id: \.self) { topic in
                            Text(topic)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(15)
                                .overlay(
                                    Button(action: { removeTopic(topic) }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.red)
                                            .offset(x: 8, y: -8)
                                    },
                                    alignment: .topTrailing
                                )
                        }
                    }
                    .padding(.vertical, 5)
                }
                .frame(minHeight: 50)
            }

            Spacer()

            // MARK: - Create Group Button
            Button(action: createGroup) {
                HStack {
                    Spacer()
                    Text("Create Group")
                        .font(.headline)
                        .foregroundColor(.white)
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(groupName.isEmpty ? Color.gray : Color.blue)
                .cornerRadius(15)
                .shadow(radius: 3)
            }
            .disabled(groupName.isEmpty)
            .padding(.bottom, 20)
        }
        .padding()
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Creation Failed"),
                message: Text(errorMessage),
                dismissButton: .default(Text("OK")) {
                    viewContext.rollback()
                }
            )
        }
    }
    
    // MARK: - Core Data Operations
    private func createGroup() {
        guard !groupName.isEmpty else {
            showError(message: "Please enter a group name")
            return
        }
        
        guard groupName.count >= 3 && groupName.count <= 25 else {
            showError(message: "Group name must be 3-25 characters")
            return
        }

        let newGroup = StudyGroup(context: viewContext)
        newGroup.id = UUID()
        newGroup.name = groupName.trimmingCharacters(in: .whitespacesAndNewlines)
        newGroup.features = (selectedFeatures as NSArray).mutableCopy() as! NSMutableArray
        newGroup.topics = (studyTopics as NSArray).mutableCopy() as! NSMutableArray
        newGroup.code = generateGroupCode()
        newGroup.members = 1
        newGroup.isOpen = true
        newGroup.isMember = true
        newGroup.createdAt = Date()

        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch let error as NSError {
            showError(message: "Failed to create group:\n\(error.localizedDescription)")
            viewContext.delete(newGroup)
            viewContext.rollback()
        }
    }

    // MARK: - Helper Functions
    private func toggleFeature(_ feature: String) {
        if selectedFeatures.contains(feature) {
            selectedFeatures.removeAll { $0 == feature }
        } else {
            selectedFeatures.append(feature)
        }
    }
    
    private func addTopic() {
        let trimmedTopic = newTopic.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTopic.isEmpty else { return }
        
        if !studyTopics.contains(trimmedTopic) {
            studyTopics.append(trimmedTopic)
            newTopic = ""
        }
    }
    
    private func removeTopic(_ topic: String) {
        studyTopics.removeAll { $0 == topic }
    }
    
    private func generateGroupCode() -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<6).map { _ in letters.randomElement()! })
    }
    
    private func showError(message: String) {
        errorMessage = message
        showErrorAlert = true
    }
}

struct CreateGroupView_Preview: PreviewProvider {
    static var previews: some View {
        CreateGroupView()  
    }
}
