//
//  PomodoroTimerApp.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-10.
//

import SwiftUI
import CoreData

struct PomodoroTimerApp: View {
    // MARK: - state properties
    @State private var mode: PomodoroMode = .pomodoro  // current timer mode
    @State private var timeRemaining: Int = PomodoroMode.pomodoro.rawValue  // seconds remaining
    @State private var isActive: Bool = false  // timer active state

    var body: some View {
        VStack {
            // Timer container
            ZStack {
                // background panel
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 360, height: 320)
                    .shadow(radius: 5)

                VStack {
                    // mode selection
                    PomodoroModeButton(
                        title: "Pomodoro",
                        mode: .pomodoro,
                        currentMode: $mode,
                        timeRemaining: $timeRemaining,
                        isActive: $isActive
                    )
                    
                    HStack {
                        PomodoroModeButton(
                            title: "Short Break",
                            mode: .shortBreak,
                            currentMode: $mode,
                            timeRemaining: $timeRemaining,
                            isActive: $isActive
                        )
                        PomodoroModeButton(
                            title: "Long Break",
                            mode: .longBreak,
                            currentMode: $mode,
                            timeRemaining: $timeRemaining,
                            isActive: $isActive
                        )
                    }
                    .padding()

                    // Timer Display
                    TimerView(timeRemaining: timeRemaining)

                    // Start/Pause Button
                    Button(action: { isActive.toggle() }) {
                        Text(isActive ? "Pause" : "Start")
                            .font(.title)
                            .frame(width: 140, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 10)
                }
            }
            .padding()

            // task list
            PomodoroTaskListView()
        }
        .padding()
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
        .onAppear(perform: startTimer)
    }

    
    // MARK: - timer logic
    // starts the countdown timer
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if isActive && timeRemaining > 0 {
                timeRemaining -= 1
            }
            if timeRemaining == 0 {
                isActive = false
                timer.invalidate()
            }
        }
    }
}

// MARK: - task list components
struct PomodoroTaskListView: View {
    // core data properties
    @Environment(\.managedObjectContext) private var viewContext
    @State private var newTask: String = ""
    
    // fetched tasks sorted by completion status and text
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \PomodoroTask.completed, ascending: true),
            NSSortDescriptor(keyPath: \PomodoroTask.text, ascending: true)
        ],
        animation: .default
    ) private var tasks: FetchedResults<PomodoroTask>

    var body: some View {
        VStack {
            Spacer()
            VStack {
                // task list header
                Text("Tasks")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                // Task input
                HStack {
                    TextField("Add Task", text: $newTask)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(height: 40)
                    
                    Button(action: addTask) {
                        Text("+")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }

            // Task List
            ZStack {
                List {
                    ForEach(tasks, id: \.id) { task in
                        PomodoroTaskListItem(
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
    }

    // MARK: - Core Data Operations
    // adds a new task to core data
    private func addTask() {
        guard !newTask.isEmpty else { return }
        
        let newTaskItem = PomodoroTask(context: viewContext)
        newTaskItem.id = UUID()
        newTaskItem.text = newTask
        newTaskItem.completed = false
        
        do {
            try viewContext.save()
            newTask = ""
        } catch {
            print("Error saving Pomodoro task: \(error)")
        }
    }

    // toggles completion status
    private func toggleTaskCompletion(for task: PomodoroTask) {
        task.completed.toggle()
        do {
            try viewContext.save()
        } catch {
            print("Error updating Pomodoro task: \(error)")
        }
    }

    // deletes a task from core data
    private func removeTask(for task: PomodoroTask) {
        viewContext.delete(task)
        do {
            try viewContext.save()
        } catch {
            print("Error deleting Pomodoro task: \(error)")
        }
    }
}

// MARK: - Task List Item
struct PomodoroTaskListItem: View {
    // properties
    var task: PomodoroTask
    var toggleCompletion: () -> Void
    var deleteTask: () -> Void

    var body: some View {
        HStack {
            // Task Info
            HStack {
                Button(action: toggleCompletion) {
                    Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(task.completed ? .green : .gray)
                }
                .buttonStyle(BorderlessButtonStyle())

                // task text
                Text(task.text ?? "")
                    .strikethrough(task.completed, color: .black)
                    .foregroundColor(.black)
            }
            .contentShape(Rectangle())
            .onTapGesture { toggleCompletion() }

            Spacer()

            // Delete Button
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

// MARK: - Supporting Components
// displays formatted timer
struct TimerView: View {
    var timeRemaining: Int
    
    var body: some View {
        Text(String(format: "%02d:%02d", timeRemaining / 60, timeRemaining % 60))
            .font(.system(size: 40, weight: .bold))
            .foregroundColor(.black)
    }
}

// mode selection button
struct PomodoroModeButton: View {
    var title: String
    var mode: PomodoroMode
    @Binding var currentMode: PomodoroMode
    @Binding var timeRemaining: Int
    @Binding var isActive: Bool
    
    var body: some View {
        Button(action: {
            currentMode = mode
            timeRemaining = mode.rawValue
            isActive = false
        }) {
            Text(title)
                .padding()
                .background(currentMode == mode ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

// MARK: - Pomodoro Mode Enum
// defines different timer durations
enum PomodoroMode: Int {
    case pomodoro = 1500    // 25 minutes
    case shortBreak = 300   // 5 minutes
    case longBreak = 900    // 15 minutes
}

// MARK: - Preview
//#Preview {
//    PomodoroTimerApp()
//        .environment(\.managedObjectContext, CoreDataManager.shared.container.viewContext)
//}
