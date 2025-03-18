//
//  CoreDataManager.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-11.
//


import CoreData
import SwiftUI

class CoreDataManager {
    static let shared = CoreDataManager() // Singleton instance
    let container: NSPersistentContainer

    init() {
        NSArrayTransformer.register()
        container = NSPersistentContainer(name: "StudyBuddyDataModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data store: \(error)")
            }
        }
    }

    // save context
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
