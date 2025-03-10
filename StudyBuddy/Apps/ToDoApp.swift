//
//  ToDoApp.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-04.
//

import SwiftUI

// struct representing a single to-do item
struct ToDoItem: Identifiable {
    let id = UUID() // unique identifier for each task
    var text: String // task description
    var isCompleted: Bool // task status (checked or unchecked)
}

struct ToDoApp: View {
    @State private var newTask: String = "" // holds input from the text field
    @State private var tasks: [ToDoItem] = [] // list of tasks

    var body: some View {
        VStack {
            Text("To-Do List")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding()

            // input area with a text field and add button
            HStack {
                TextField("enter a task", text: $newTask)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
                
                Button(action: {
                    addTask()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                }
                .padding(.trailing)
            }
            .padding(.bottom)

            // list of tasks, sorted so unchecked tasks appear first
            List {
                ForEach(sortedTasks.indices, id: \.self) { index in
                    HStack {
                        // toggle button to mark task as complete or incomplete
                        Button(action: {
                            toggleTaskCompletion(for: sortedTasks[index])
                        }) {
                            Image(systemName: sortedTasks[index].isCompleted ? "checkmark.circle.fill" : "circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(sortedTasks[index].isCompleted ? .green : .gray)
                        }
                        .buttonStyle(BorderlessButtonStyle()) // prevents button interaction issues inside the list

                        // task text with strikethrough if completed
                        Text(sortedTasks[index].text)
                            .strikethrough(sortedTasks[index].isCompleted, color: .black)
                            .foregroundColor(.black)
                        
                        Spacer()

                        // delete button (red trash icon)
                        Button(action: {
                            removeTask(for: sortedTasks[index])
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            .listStyle(PlainListStyle()) // removes default list styling
        }
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
    }

    // property to sort tasks so unchecked tasks appear first
    private var sortedTasks: [ToDoItem] {
        tasks.sorted { !$0.isCompleted && $1.isCompleted }
    }

    // adds a new task to the list
    private func addTask() {
        if !newTask.isEmpty {
            tasks.append(ToDoItem(text: newTask, isCompleted: false))
            newTask = "" // clears input field after adding a task
        }
    }

    // toggles task completion status
    private func toggleTaskCompletion(for task: ToDoItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }

    // removes a task from the list
    private func removeTask(for task: ToDoItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
        }
    }
}

#Preview {
    ToDoApp()
}
