//
//  NoteDetailView.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-11.
//

import SwiftUI

struct NoteDetailView: View {
    @State var note: Note // current note being edited
    @Binding var notes: [Note]
    @Environment(\.presentationMode) var presentationMode // handles back navigation

    var body: some View {
        VStack {
            Text("Edit Note")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()

            TextEditor(text: $note.text)
                .frame(height: 300)
                .padding()
                .background(Color.white)
                .cornerRadius(10)

            // Save Button
            Button(action: {
                saveNote()
                presentationMode.wrappedValue.dismiss() // return to notes list
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

    // save or update note
    private func saveNote() {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index] = note // update existing note
        } else {
            notes.append(note) // save new note
        }
    }
}
