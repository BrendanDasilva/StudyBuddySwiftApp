//
//  ToDoItem.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-10.
//

import Foundation

// struct representing a single to-do task
struct ToDoItem: Identifiable {
    let id = UUID() // unique identifier for each task
    var text: String // task description
    var isCompleted: Bool = false // task status (checked or unchecked)
}
