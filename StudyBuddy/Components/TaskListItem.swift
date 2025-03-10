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
            // toggle button to mark task as complete or incomplete
            Button(action: toggleCompletion) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }
            .buttonStyle(BorderlessButtonStyle())

            // task text with strikethrough if completed
            Text(task.text)
                .strikethrough(task.isCompleted, color: .black)
                .foregroundColor(.black)

            Spacer()

            // delete button (red trash icon)
            Button(action: deleteTask) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding(6)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
