//
//  CreateGroupView.swift
//  StudyBuddy
//

import SwiftUI

struct CreateGroupView: View {
    @State private var groupName: String = ""
    @State private var selectedOptions: [String] = []
    @State private var studyTopics: [String] = []
    @State private var newTopic: String = ""

    let availableOptions = ["Courses", "Scheduler", "Pomodoro Timer", "Flash Cards", "To-Do List", "Notes"]

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // page title
            Text("Create a Study Group")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)

            // group name input
            VStack(alignment: .leading, spacing: 5) {
                Text("Group Name")
                    .foregroundColor(.white.opacity(0.8))
                TextField("", text: $groupName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                Text("Required")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
            }

            // checkboxes for include options
            Text("Include")
                .foregroundColor(.white.opacity(0.8))
            ForEach(availableOptions, id: \.self) { option in
                HStack {
                    Image(systemName: selectedOptions.contains(option) ? "checkmark.square.fill" : "square")
                        .resizable()
                        .frame(width: 25, height: 25) // ✅ Bigger checkbox
                        .foregroundColor(.purple)
                        .onTapGesture {
                            if selectedOptions.contains(option) {
                                selectedOptions.removeAll { $0 == option }
                            } else {
                                selectedOptions.append(option)
                            }
                        }
                    Text(option)
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }

            // add space between checkboxes and input - maybe have a better visual indicator and tighen it up
            Divider()
                .background(Color.white.opacity(0.5))
                .padding(.vertical, 10)

            // study topics input
            VStack(alignment: .leading, spacing: 5) {
                Text("Study Topics")
                    .foregroundColor(.white.opacity(0.8))
                HStack {
                    TextField("", text: $newTopic)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        if !newTopic.isEmpty {
                            studyTopics.append(newTopic)
                            newTopic = ""
                        }
                    }) {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.purple)
                    }
                }
            }

            Spacer() // pushes the button to the bottom

            // create group button
            Button(action: {
                print("Group Created!")
            }) {
                HStack {
                    Spacer()
                    Text("Create Group")
                        .font(.headline)
                        .foregroundColor(.white)
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding(.bottom, 20)

        }
        .padding()
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
    }
}
