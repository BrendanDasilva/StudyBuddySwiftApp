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
            // ✅ Mode Selection Buttons
            HStack {
                PomodoroModeButton(title: "Pomodoro", mode: .pomodoro, currentMode: $mode, timeRemaining: $timeRemaining, isActive: $isActive)
                PomodoroModeButton(title: "Short Break", mode: .shortBreak, currentMode: $mode, timeRemaining: $timeRemaining, isActive: $isActive)
                PomodoroModeButton(title: "Long Break", mode: .longBreak, currentMode: $mode, timeRemaining: $timeRemaining, isActive: $isActive)
            }
            .padding()

            // ✅ Timer Display
            TimerView(timeRemaining: timeRemaining)

            // ✅ Start/Pause Button
            Button(action: {
                isActive.toggle()
            }) {
                Text(isActive ? "Pause" : "Start")
                    .font(.title)
                    .frame(width: 150, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            // ✅ Task List
            TaskListView(tasks: $tasks)

            Spacer()
        }
        .padding()
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
        .onAppear {
            startTimer()
        }
    }

    // ✅ Timer Functionality
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

// ✅ Timer Display Component
struct TimerView: View {
    var timeRemaining: Int

    var body: some View {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60

        return Text(String(format: "%02d:%02d", minutes, seconds))
            .font(.system(size: 60, weight: .bold))
            .foregroundColor(.white)
            .padding()
    }
}

// ✅ Mode Selection Button
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

// ✅ Task List Component
struct TaskListView: View {
    @Binding var tasks: [TaskItem]
    @State private var newTask: String = ""

    var body: some View {
        VStack {
            Text("Tasks")
                .font(.title2)
                .foregroundColor(.white)

            HStack {
                TextField("Add Task", text: $newTask)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    if !newTask.isEmpty {
                        tasks.append(TaskItem(text: newTask))
                        newTask = ""
                    }
                }) {
                    Text("+")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()

            List {
                ForEach(tasks.indices, id: \.self) { index in
                    HStack {
                        Button(action: {
                            tasks[index].completed.toggle()
                        }) {
                            Image(systemName: tasks[index].completed ? "checkmark.square.fill" : "square")
                                .foregroundColor(tasks[index].completed ? .green : .white)
                        }
                        Text(tasks[index].text)
                            .foregroundColor(.white)
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

// ✅ Task Model
struct TaskItem: Identifiable {
    let id = UUID()
    var text: String
    var completed: Bool = false
}

// ✅ Pomodoro Modes
enum PomodoroMode: Int {
    case pomodoro = 1500   // 25 minutes
    case shortBreak = 300  // 5 minutes
    case longBreak = 900   // 15 minutes
}
