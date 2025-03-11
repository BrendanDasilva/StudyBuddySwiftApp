//
//  NoteDetailView.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-11.
//

import SwiftUI
import CoreData

struct NoteDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var isPresented: Bool
    @State private var text: String
    private var note: NoteEntity?
    
    // MARK: - Initializer for Core Data integration
    init(note: NoteEntity?, isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        self.note = note
        self._text = State(initialValue: note?.text ?? "")
    }
    
    var body: some View {
        VStack {
            Text(note == nil ? "New Note" : "Edit Note")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
            
            TextEditor(text: $text)
                .frame(height: 300)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .foregroundColor(.black)
            
            // MARK: - Save Button
            Button(action: {
                saveNote()
                isPresented = false
            }) {
                Text("Save Note")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
    }
    
    // MARK: - Core Data Operations
    private func saveNote() {
        let currentNote: NoteEntity
        
        if let existingNote = note {
            // Update existing note
            currentNote = existingNote
        } else {
            // Create new note entity
            currentNote = NoteEntity(context: viewContext)
            currentNote.id = UUID()
        }
        
        currentNote.text = text
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving note: \(error)")
        }
    }
}
