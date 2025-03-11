//
//  NotesApp.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-04.
//

import SwiftUI
import CoreData

struct NotesApp: View {
    @State private var notes: [Note] = []           // stores all notes
    @State private var showingNoteDetail = false    // controls detail view presentation
    @State private var selectedNote: Note?          // currently selected note for editing

    var body: some View {
        NavigationView {
            VStack {
                // header
                Text("Notes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)

                // add note button
                Button(action: {
                    selectedNote = nil // clear selection for new note creation
                    showingNoteDetail = true // show note detail view
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

                // notes list
                List {
                    ForEach(notes) { note in
                        // note list item
                        Button(action: {
                            selectedNote = note // set selected note for editing
                            showingNoteDetail = true // show detail view
                        }) {
                            // note content preview
                            Text(note.text)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        }
                        // swipe to delete functionality
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
            // note detail sheet
            .sheet(isPresented: $showingNoteDetail) {
                // show either existing note or new note
                if let selectedNote = selectedNote {
                    NoteDetailView(note: selectedNote, notes: $notes)
                } else {
                    NoteDetailView(note: Note(text: ""), notes: $notes)
                }
            }
            // layout and styling
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
        }
    }

    // function to delete a note
    private func deleteNote(_ note: Note) {
        notes.removeAll { $0.id == note.id }
    }
}

// MARK: - note Model representing a single note
struct Note: Identifiable {
    let id = UUID()
    var text: String
}
