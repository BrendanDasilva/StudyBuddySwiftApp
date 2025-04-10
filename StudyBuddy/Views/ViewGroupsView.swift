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
                            // Simplify and use NavigationLink here
                            ForEach(groups) { group in
                                GroupTileNavigation(group: group)
                                    .contextMenu {
                                        Button(action: {
                                            // Action for view/edit details
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
    }
}

#Preview {
    ViewGroupsView()
}
