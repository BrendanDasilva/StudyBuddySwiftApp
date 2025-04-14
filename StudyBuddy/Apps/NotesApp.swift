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
                    .font(.custom("HelveticaNeue-Bold", size: 60))
                    .foregroundColor(Color.white)
                    .shadow(color: Color.gray, radius: 8, x: 0, y: 8)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 30)

                // MARK: - Notes List
                List {
                    ForEach(notes) { note in
                        // MARK: - Note List Item
                        Button(action: {
                            selectedNote = note
                            showingNoteDetail = true
                        }) {
                            HStack {
                                Text(note.text ?? "")
                                    .font(.custom("Menlo-Bold", size: 16))
                                    .cornerRadius(5)
                                    .padding(.leading, 20)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(#colorLiteral(red: 0.8015663495, green: 0.9380386521, blue: 0.9764705896, alpha: 1)))
                            .cornerRadius(10)
                            .padding(.horizontal, 5)
                        }
                        .listRowBackground(Color.clear)
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
                .background(Color.clear)
                .listRowSeparator(.hidden)
                .scrollContentBackground(.hidden)
               
                
                // MARK: - Add Note Button
                Button(action: {
                    selectedNote = nil
                    showingNoteDetail = true
                }) {
                    Text("Add Note")
                        .font(.custom("Menlo-Bold", size: 16))
                        .frame(width: 300, height: 50)
                        .background(Color.clear)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(#colorLiteral(red: 0.1701194298, green: 0.1297623498, blue: 0.2721540133, alpha: 1)), lineWidth: 2))
                        .shadow(color: Color(#colorLiteral(red: 0.13401145, green: 0.1061868557, blue: 0.2262137172, alpha: 0.7275455298)), radius: 4, x: -3, y: -3)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
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
struct NotesApp_Previews: PreviewProvider {
    static var previews: some View {
        NotesApp()
    }
}
//#Preview {
//    NotesApp()
//        .environment(\.managedObjectContext, CoreDataManager.shared.container.viewContext)
//}
