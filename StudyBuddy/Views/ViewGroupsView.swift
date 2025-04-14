import SwiftUI
import CoreData

struct ViewGroupsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StudyGroup.createdAt, ascending: false)],
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
                                GroupTileNavigationView(group: group)
                                    .contextMenu {
                                        Button(action: {
                                            print("View/Edit Group Details tapped for \(group.name ?? "")")
                                        }) {
                                            Label("View/Edit Details", systemImage: "pencil")
                                        }
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }

                    Spacer()
                }
                .padding()
            }
        }
        .onAppear {
            fetchGroupsFromBackend()
        }
    }

    // Function to fetch groups from the backend
    private func fetchGroupsFromBackend() {
        guard let url = URL(string: "https://your-backend-api.com/api/groups") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch groups: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let fetchedGroups = try decoder.decode([StudyGroupDecodable].self, from: data)

                // Save each group to Core Data
                for group in fetchedGroups {
                    saveStudyGroupToCoreData(from: group)
                }

            } catch {
                print("Failed to decode groups: \(error.localizedDescription)")
            }
        }.resume()
    }

    // Function to save fetched data to Core Data
    private func saveStudyGroupToCoreData(from group: StudyGroupDecodable) {
        let newGroup = StudyGroup(context: viewContext)
        newGroup.id = UUID(uuidString: group.id ?? "")
        newGroup.name = group.name
        newGroup.features = group.features as NSArray?  // Convert to NSArray
        newGroup.topics = group.topics as NSArray?      // Convert to NSArray
        newGroup.createdAt = group.createdAt != nil ? ISO8601DateFormatter().date(from: group.createdAt!) : nil
        newGroup.members = Int64(Int64(group.members ?? 0))

        do {
            try viewContext.save()
        } catch {
            print("Error saving group: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ViewGroupsView()
}
