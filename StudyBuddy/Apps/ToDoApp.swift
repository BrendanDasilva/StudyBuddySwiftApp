//
//  ToDoApp.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-04.
//
// ToDoApp.swift

import SwiftUI

// main view for the to-do list app
struct ToDoApp: View {
    @State private var newTask: String = "" // stores user input for a new task
    @State private var tasks: [ToDoItem] = [] // list of tasks

    var body: some View {
        VStack {
            Text("To-Do List")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding()

            // input field and add task button
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

            // task list container
            ZStack {
                List {
                    ForEach(sortedTasks.indices, id: \.self) { index in
                        TaskListItem(
                            task: sortedTasks[index],
                            toggleCompletion: { toggleTaskCompletion(for: sortedTasks[index]) },
                            deleteTask: { removeTask(for: sortedTasks[index]) }
                        )
                    }
                }
                .listStyle(PlainListStyle()) // removes default list styling
                .frame(width: 360) // matches width with pomodoro list for consistency
            }
            .padding()
        }
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all)) // sets app background color
    }

    // computed property to sort tasks (unchecked first, checked last)
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

// preview for swiftui live rendering
#Preview {
    ToDoApp()
}
