//
//  ToDoApp.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-04.
//

import SwiftUI

struct ToDoApp: View {
    @State private var tasks: [String] = [] // store tasks
    @State private var newTask: String = "" // stores input value
    
    var body: some View {
        VStack {
            Text("To-Do List")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding()
            
            // input area
            InputArea(newTask: $newTask, tasks: $tasks)
                .padding(.horizontal, 20)
            
            // task list
            List {
            ForEach(tasks, id: \..self) { task in
                ToDoItem(task: task, tasks: $tasks)
            }
            .onDelete { indexSet in
                tasks.remove(atOffsets: indexSet)
            }
        }
        .listStyle(PlainListStyle())
    }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
    }
}


// input area component
struct InputArea: View {
    @Binding var newTask: String
    @Binding var tasks: [String]
    
    var body: some View {
        HStack {
            TextField("Enter a task", text: $newTask)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                if !newTask.isEmpty {
                    tasks.append(newTask)
                    newTask = ""
                }
            }) {
                Image(systemName: "plus")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
        }
    }
}



// todo item component
struct ToDoItem: View {
    let task: String
    @Binding var tasks: [String]
    
    var body: some View {
        HStack {
            Text(task)
                .foregroundColor(.black)
                .padding()
            Spacer()
            
            Button(action: {
                if let index = tasks.firstIndex(of: task) {
                    tasks.remove(at: index)
                }
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}


#Preview {
    ToDoApp()
}
