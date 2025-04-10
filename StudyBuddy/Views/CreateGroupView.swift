import SwiftUI
import CoreData

struct CreateGroupView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var groupName: String = ""
    @State private var selectedFeatures: [String] = []
    @State private var studyTopics: [String] = []
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    let availableFeatures = ["Courses", "Scheduler", "Pomodoro Timer", "Flash Cards", "To-Do List", "Notes"]

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // Group Name Input
            TextField("Group Name", text: $groupName)
                .padding()
                .background(Color.white)
                .cornerRadius(5)
            
            // Feature Selection
            VStack(alignment: .leading) {
                Text("Include Features")
                    .font(.headline)
                ForEach(availableFeatures, id: \.self) { feature in
                    HStack {
                        Image(systemName: selectedFeatures.contains(feature) ? "checkmark.square.fill" : "square")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .onTapGesture {
                                toggleFeature(feature)
                            }
                        Text(feature)
                            .font(.body)
                    }
                }
            }
            
            // Create Group Button
            Button(action: createGroup) {
                Text("Create Group")
                    .padding()
                    .background(groupName.isEmpty ? Color.gray : Color.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
            .disabled(groupName.isEmpty)
            .padding(.top, 20)
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
        .padding()
    }

    // Helper Functions
    private func createGroup() {
        guard !groupName.isEmpty else {
            showError(message: "Please enter a group name")
            return
        }

        // Create StudyGroup locally (Core Data)
        let newGroup = StudyGroup(context: viewContext)
        newGroup.id = UUID()
        newGroup.name = groupName
        newGroup.features = selectedFeatures as NSArray
        newGroup.topics = studyTopics as NSArray
        newGroup.createdAt = Date()

        // Send to Backend
        sendGroupToBackend(group: newGroup)

        // Save to Core Data
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()  // Close the create view
        } catch {
            showError(message: "Failed to save group locally: \(error.localizedDescription)")
        }
    }

    private func sendGroupToBackend(group: StudyGroup) {
        guard let url = URL(string: "https://your-backend-api.com/api/groups/create") else {
            showError(message: "Invalid backend URL")
            return
        }

        let payload: [String: Any] = [
            "name": group.name ?? "",
            "members": 1,  // Assuming one member initially
            "features": group.features ?? [],
            "topics": group.topics ?? [],
            "createdAt": group.createdAt ?? Date()
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: payload) else {
            showError(message: "Invalid group data")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.showError(message: "Failed to send group data to the backend: \(error.localizedDescription)")
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                DispatchQueue.main.async {
                    self.showError(message: "Failed to create group on backend")
                }
                return
            }

            DispatchQueue.main.async {
                self.showError(message: "Group created successfully!")
            }
        }.resume()
    }

    private func showError(message: String) {
        errorMessage = message
        showErrorAlert = true
    }

    private func toggleFeature(_ feature: String) {
        if selectedFeatures.contains(feature) {
            selectedFeatures.removeAll { $0 == feature }
        } else {
            selectedFeatures.append(feature)
        }
    }
}

#Preview {
    CreateGroupView()
}
