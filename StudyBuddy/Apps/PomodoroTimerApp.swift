//
//  PomodoroTimerApp.swift
//  StudyBuddy
//


import SwiftUI

struct PomodoroTimerApp: View {
    @State private var mode: PomodoroMode = .pomodoro
    @State private var timeRemaining: Int = PomodoroMode.pomodoro.rawValue
    @State private var isActive: Bool = false
    @State private var tasks: [TaskItem] = []

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 360, height: 320)
                    .shadow(radius: 5)

                VStack {
                    // mode selection buttons
                    PomodoroModeButton(title: "Pomodoro", mode: .pomodoro, currentMode: $mode, timeRemaining: $timeRemaining, isActive: $isActive)
                    
                    HStack {
                        PomodoroModeButton(title: "Short Break", mode: .shortBreak, currentMode: $mode, timeRemaining: $timeRemaining, isActive: $isActive)
                        PomodoroModeButton(title: "Long Break", mode: .longBreak, currentMode: $mode, timeRemaining: $timeRemaining, isActive: $isActive)
                    }
                    .padding()

                    // timer display
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

            // task list
            TaskListView(tasks: $tasks)
        }
        .padding()
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
        .onAppear {
            startTimer()
        }
    }

    // timer functionality
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

// Task List Component
struct TaskListView: View {
    @Binding var tasks: [TaskItem]
    @State private var newTask: String = ""

    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Tasks")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                // task Input
                HStack {
                    TextField("Add Task", text: $newTask)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(height: 40)
                    Button(action: {
                        if !newTask.isEmpty {
                            tasks.append(TaskItem(text: newTask))
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

            // task List
            List {
                ForEach(tasks.indices, id: \.self) { index in
                    HStack {
                        Button(action: {
                            tasks[index].completed.toggle()
                        }) {
                            Image(systemName: tasks[index].completed ? "checkmark.square.fill" : "square")
                                .foregroundColor(tasks[index].completed ? .green : .black) // checkbox remains visible
                        }
                        Text(tasks[index].text)
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

// Task Model
struct TaskItem: Identifiable {
    let id = UUID()
    var text: String
    var completed: Bool = false
}

// Pomodoro Modes
enum PomodoroMode: Int {
    case pomodoro = 1500   // 25 minutes
    case shortBreak = 300  // 5 minutes
    case longBreak = 900   // 15 minutes
}
