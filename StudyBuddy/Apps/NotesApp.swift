//
//  NotesApp.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-04.
//

import SwiftUI
import CoreData

struct NotesApp: View {
    // MARK: - Core Data Properties
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingNoteDetail = false
    @State private var selectedNote: NoteEntity?
    
    // Fetch notes sorted by creation date (add 'createdDate' attribute to NoteEntity if needed)
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \NoteEntity.id, ascending: true)],
        animation: .default
    ) private var notes: FetchedResults<NoteEntity>

    var body: some View {
        NavigationView {
            VStack {
                // MARK: - Header
                Text("Notes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)

                // MARK: - Add Note Button
                Button(action: {
                    selectedNote = nil
                    showingNoteDetail = true
                }) {
                    Text("Add Note")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)

                // MARK: - Notes List
                List {
                    ForEach(notes) { note in
                        // MARK: - Note List Item
                        Button(action: {
                            selectedNote = note
                            showingNoteDetail = true
                        }) {
                            Text(note.text ?? "")
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteNote(note)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            // MARK: - Note Detail Sheet
            .sheet(isPresented: $showingNoteDetail) {
                NoteDetailView(note: selectedNote, isPresented: $showingNoteDetail)
                    .environment(\.managedObjectContext, viewContext)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
        }
    }

    // MARK: - Core Data Operations
    private func deleteNote(_ note: NoteEntity) {
        viewContext.delete(note)
        do {
            try viewContext.save()
        } catch {
            print("Error deleting note: \(error)")
        }
    }
}


// MARK: - Preview
//#Preview {
//    NotesApp()
//        .environment(\.managedObjectContext, CoreDataManager.shared.container.viewContext)
//}
