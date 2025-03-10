//
//  ToDoApp.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-04.
//
// ToDoApp.swift

import SwiftUI

struct ToDoApp: View {
    @State private var newTask: String = ""
    @State private var tasks: [ToDoItem] = []

    var body: some View {
        VStack {
            Text("To-Do List")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding()

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

            // white background container matching Pomodoro list
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
                .listStyle(PlainListStyle())
                .frame(width: 360)
            }
            .padding()
        }
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
    }

    private var sortedTasks: [ToDoItem] {
        tasks.sorted { !$0.isCompleted && $1.isCompleted }
    }

    private func addTask() {
        if !newTask.isEmpty {
            tasks.append(ToDoItem(text: newTask, isCompleted: false))
            newTask = ""
        }
    }

    private func toggleTaskCompletion(for task: ToDoItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }

    private func removeTask(for task: ToDoItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
        }
    }
}

#Preview {
    ToDoApp()
}
