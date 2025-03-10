//
//  TaskListItem.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-10.
//

import SwiftUI

struct TaskListItem: View {
    var task: ToDoItem
    var toggleCompletion: () -> Void
    var deleteTask: () -> Void

    var body: some View {
        HStack {
            // make the entire left side of the row (toggle + text) tappable for completion toggle
            HStack {
                Button(action: toggleCompletion) {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(task.isCompleted ? .green : .gray)
                }
                .buttonStyle(BorderlessButtonStyle())

                Text(task.text)
                    .strikethrough(task.isCompleted, color: .black)
                    .foregroundColor(.black)
            }
            .contentShape(Rectangle()) // ensures only this part toggles completion
            .onTapGesture {
                toggleCompletion()
            }

            Spacer()

            // delete button - only the icon should be clickable
            Button(action: deleteTask) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .buttonStyle(BorderlessButtonStyle()) // ensures no extra tap area
        }
        .padding(6)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
