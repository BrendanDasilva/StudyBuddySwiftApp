# 📚 StudyBuddy

**StudyBuddy** is a feature-rich SwiftUI iOS app designed to help students plan, track, and enhance their study sessions. This productivity-focused app allows users to create or join collaborative study groups and use a variety of built-in study tools like flashcards, Pomodoro timers, schedulers, and to-do lists.

---

## 👨‍💻 Developed By

- **Brendan DaSilva**
- **Jessica Lee**
- **Kailie Field**
- **Lucas Caridi**

---

## 🚀 Features

### 🔐 Authentication
- User registration and login with persistent session tracking
- "Remember Me" functionality using `UserDefaults`

### 🏠 Home & Account
- Dynamic Welcome screen with four study options
- Personalized Account tab with user info and settings
- Support for theme preferences, cache clearing, and logout

### 👥 Study Group Management
- **Create a Study Group** with features and custom study topics
- **Join Group** by code or from list of open groups
- **View Your Groups** with direct access to group apps
- **Group Details View** with metadata and management actions

### 🧠 Study Apps Suite
Each study group (or solo session) grants access to the following tools:

- **📓 Notes App**
  - Create, view, edit, and delete personal notes
  - Stored using Core Data

- **✅ To-Do List**
  - Add, complete, and delete tasks
  - Tasks sorted and stored via Core Data

- **🕒 Pomodoro Timer**
  - Custom timer with Pomodoro, Short Break, and Long Break modes
  - Task tracking built into the timer experience

- **🧠 Flash Cards**
  - Create, flip, edit, and delete flashcards
  - Stored in `UserDefaults` per group
  - Public/private visibility toggle planned for future update

- **📅 Scheduler**
  - Placeholder screen for upcoming scheduling features

- **📘 Courses**
  - Placeholder for course-specific content or integration

---

## 🧰 Tech Stack

- **Frontend**: SwiftUI (iOS 17+)
- **State Management**: @State, @Binding, @FetchRequest
- **Local Persistence**: Core Data, UserDefaults
- **Networking**: URLSession with JSONDecoder
- **Authentication**: Basic login/registration with persistence
- **Design**: Custom color palette (#8AACEA), consistent shadowed cards and Menlo/Helvetica fonts

---

## 🗂 File Structure

```
StudyBuddy/
├── Apps/
│   ├── CoursesApp.swift
│   ├── FlashCardsApp.swift
│   ├── NotesApp.swift
│   ├── PomodoroTimerApp.swift
│   ├── SchedulerApp.swift
│   └── ToDoApp.swift
├── Components/
│   ├── GroupTile.swift
│   ├── NoteDetailView.swift
│   ├── StudyAppGridButton.swift
│   ├── StudyBuddyButton.swift
│   └── TaskListItem.swift
├── Models/
│   └── FlashCard.swift
├── Preview Content/
│   └── Preview Assets/
├── Utilities/
│   ├── ColorExtensions.swift
│   └── NSArrayTransformer.swift
├── Views/
│   ├── AccountView.swift
│   ├── CreateGroupView.swift
│   ├── GroupDetailView.swift
│   ├── GroupTileNavigationView.swift
│   ├── HomeView.swift
│   ├── JoinGroupView.swift
│   ├── LoginView.swift
│   ├── RegisterView.swift
│   ├── StudyAppsView.swift
│   ├── StudyGroupDecodable.swift
│   ├── ViewGroupsView.swift
│   └── WelcomeView.swift
├── Fonts/
│   ├── Anybody-Bold.ttf
│   └── Anybody-Regular.ttf
├── Assets/
├── ContentView.swift
├── CoreDataManager.swift
├── NetworkHelper.swift
├── StudyBuddyApp.swift
├── StudyBuddyDataModel/
└── studybuddy-backend/
    └── node_modules/
```

---

## ✅ Requirements

- iOS 17+
- Xcode 15+
- Swift 5.9+

---

## 💡 Setup Instructions

1. Clone this repository.
2. Open `StudyBuddy.xcodeproj` in Xcode.
3. Build and run the app using the latest iPhone simulator or a physical device.

---

## 🏁 Final Notes

This app was built as part of a group project to explore real-world SwiftUI development, Core Data integration, and mobile UI design patterns. Each contributor worked on multiple features collaboratively through version control and pair programming.
