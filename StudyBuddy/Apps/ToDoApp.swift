//
//  ToDoApp.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-04.
//
// ToDoApp.swift

import SwiftUI
import CoreData

// MARK: - Main To-Do List View
struct ToDoApp: View {
    // MARK: - Core Data Properties
    @Environment(\.managedObjectContext) private var viewContext
    @State private var newTask: String = ""
    
    // Fetched tasks sorted by completion status and text
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ToDoTask.completed, ascending: true),
            NSSortDescriptor(keyPath: \ToDoTask.text, ascending: true)
        ],
        animation: .default
    ) private var tasks: FetchedResults<ToDoTask>

    var body: some View {
        VStack {
            // header
            Text("To-Do List")
                .font(.custom("HelveticaNeue-Bold", size: 60))
                .foregroundColor(Color.white)
                .shadow(color: Color.gray, radius: 4, x: 0, y: 4)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.top, 30)

            // input field
            HStack {
                TextField("enter a task", text: $newTask)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
                    .font(.custom("Menlo-Bold", size: 16))
                
                // add task button
                Button(action: addTask) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                    
                }
                .padding(.trailing)
            }
            .padding(.bottom)

            // MARK: - Task List
            ZStack {
                List {
                    ForEach(tasks, id: \.id) { task in
                        TaskListItem(
                            task: task,
                            toggleCompletion: { toggleTaskCompletion(for: task) },
                            deleteTask: { removeTask(for: task) }
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

    // MARK: - Core Data Operations
    // adds a new task to Core Data
    private func addTask() {
        guard !newTask.isEmpty else { return }
        
        let newTaskItem = ToDoTask(context: viewContext)
        newTaskItem.id = UUID()
        newTaskItem.text = newTask
        newTaskItem.completed = false
        
        do {
            try viewContext.save()
            newTask = "" // clear input field
        } catch {
            print("Error saving task: \(error)")
        }
    }

    // toggles completion status for a task
    private func toggleTaskCompletion(for task: ToDoTask) {
        task.completed.toggle()
        do {
            try viewContext.save()
        } catch {
            print("Error saving completion: \(error)")
        }
    }

    // removes a task from core data
    private func removeTask(for task: ToDoTask) {
        viewContext.delete(task)
        do {
            try viewContext.save()
        } catch {
            print("Error deleting task: \(error)")
        }
    }
}
struct ToDoApp_Preview: PreviewProvider {
    static var previews: some View {
        ToDoApp()
    }
}
