//
//  PomodoroTimerApp.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-10.
//

import SwiftUI

// main view for the pomodoro timer app
struct PomodoroTimerApp: View {
    @State private var mode: PomodoroMode = .pomodoro // current mode (pomodoro, short break, long break)
    @State private var timeRemaining: Int = PomodoroMode.pomodoro.rawValue // remaining time in seconds
    @State private var isActive: Bool = false // tracks if the timer is running
    @State private var tasks: [ToDoItem] = [] // list of tasks

    var body: some View {
        VStack {
            ZStack {
                // white background box for the timer
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 360, height: 320)
                    .shadow(radius: 5)

                VStack {
                    // pomodoro mode selection buttons
                    PomodoroModeButton(title: "Pomodoro", mode: .pomodoro, currentMode: $mode, timeRemaining: $timeRemaining, isActive: $isActive)
                    
                    HStack {
                        PomodoroModeButton(title: "Short Break", mode: .shortBreak, currentMode: $mode, timeRemaining: $timeRemaining, isActive: $isActive)
                        PomodoroModeButton(title: "Long Break", mode: .longBreak, currentMode: $mode, timeRemaining: $timeRemaining, isActive: $isActive)
                    }
                    .padding()

                    // displays the countdown timer
                    TimerView(timeRemaining: timeRemaining)

                    // start/pause button
                    Button(action: {
                        isActive.toggle()
                    }) {
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

            // task list component
            TaskListView(tasks: $tasks)
        }
        .padding()
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
        .onAppear {
            startTimer()
        }
    }

    // starts the timer and decrements the time every second
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

// task list component
struct TaskListView: View {
    @Binding var tasks: [ToDoItem] // list of tasks
    @State private var newTask: String = "" // stores user input for new task

    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Tasks")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                // input field and add task button
                HStack {
                    TextField("Add Task", text: $newTask)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(height: 40)
                    
                    Button(action: {
                        if !newTask.isEmpty {
                            tasks.append(ToDoItem(text: newTask, isCompleted: false))
                            newTask = ""
                        }
                    }) {
                        Text("+")
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }

            // list of tasks
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
    }

    // computed property to sort tasks (unchecked first, checked last)
    private var sortedTasks: [ToDoItem] {
        tasks.sorted { !$0.isCompleted && $1.isCompleted }
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

// timer display component
struct TimerView: View {
    var timeRemaining: Int

    var body: some View {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60

        return Text(String(format: "%02d:%02d", minutes, seconds))
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

// enum representing different pomodoro modes and their durations
enum PomodoroMode: Int {
    case pomodoro = 1500   // 25 minutes
    case shortBreak = 300  // 5 minutes
    case longBreak = 900   // 15 minutes
}

#Preview {
    PomodoroTimerApp()
}
