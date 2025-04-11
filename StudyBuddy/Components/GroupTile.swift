import SwiftUI
import CoreData

struct GroupTile: View {
    var group: StudyGroup
    var isJoined: Bool

    var body: some View {
        HStack {
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
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.8)))
        .cornerRadius(10)
    }
}
