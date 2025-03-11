//
//  TaskListItem.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-10.
//

import SwiftUI

struct TaskListItem: View {
    var task: ToDoTask
    var toggleCompletion: () -> Void
    var deleteTask: () -> Void

    var body: some View {
        HStack {
            // tappable area for completion toggle
            HStack {
                Button(action: toggleCompletion) {
                    Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(task.completed ? .green : .gray)
                }
                .buttonStyle(BorderlessButtonStyle())

                Text(task.text ?? "")
                    .strikethrough(task.completed, color: .black)
                    .foregroundColor(.black)
            }
            .contentShape(Rectangle())
            .onTapGesture { toggleCompletion() }

            Spacer()

            // delete button
            Button(action: deleteTask) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding(6)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
