//
//  FlashCardsApp.swift
//  StudyBuddy
//
//

import SwiftUI

struct FlashCardsApp: View {
    @State private var flashcards: [FlashCard] = []
    @State private var showAddCardForm = false
    @State private var showEditCardForm = false 
    @State private var newQuestion = ""
    @State private var newAnswer = ""
    @State private var selectedVisibility = "public"
    @State private var selectedFlashcard: FlashCard? = nil
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    // Load flashcards from UserDefaults or backend
    func loadFlashcards() {
        if let data = UserDefaults.standard.data(forKey: "flashcards") {
            let decoder = JSONDecoder()
            if let savedFlashcards = try? decoder.decode([FlashCard].self, from: data) {
                flashcards = savedFlashcards
            }
        }
    }

    // Save flashcards to UserDefaults
    func saveFlashcards() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(flashcards) {
            UserDefaults.standard.set(encoded, forKey: "flashcards")
        }
    }

    // Add a new flashcard
    func addFlashcard() {
        let newCard = FlashCard(
            id: UUID(),
            question: newQuestion,
            answer: newAnswer,
            visibility: selectedVisibility,
            groupId: "sampleGroupId", // Replace with actual group ID
            isFlipped: false // Initial state is not flipped
        )
        flashcards.append(newCard)
        saveFlashcards()
    }

    // Delete a flashcard
    func deleteFlashcard(id: UUID) {
        flashcards.removeAll { $0.id == id }
        saveFlashcards()
    }

    // Edit a flashcard
    func editFlashcard(id: UUID, question: String, answer: String) {
        if let index = flashcards.firstIndex(where: { $0.id == id }) {
            flashcards[index].question = question
            flashcards[index].answer = answer
            saveFlashcards()
        }
    }

    // Show error message
    private func showError(message: String) {
        errorMessage = message
        showErrorAlert = true
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Title
                Text("Flash Cards")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)

                // Display flashcards
                ScrollView {
                    ForEach(flashcards) { card in
                        VStack {
                            // Flip effect for each card
                            ZStack {
                                // Front side of the card
                                if card.isFlipped {
                                    Text(card.answer)
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(width: geometry.size.width - 40, height: 200)
                                        .background(Color.green)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                        .rotation3DEffect(
                                            .degrees(card.isFlipped ? 180 : 0),
                                            axis: (x: 0, y: 1, z: 0)
                                        )
                                } else {
                                    Text(card.question)
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(width: geometry.size.width - 40, height: 200)
                                        .background(Color.purple)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                        .rotation3DEffect(
                                            .degrees(card.isFlipped ? 180 : 0),
                                            axis: (x: 0, y: 1, z: 0)
                                        )
                                }
                            }
                            .onTapGesture {
                                withAnimation {
                                    if let index = flashcards.firstIndex(where: { $0.id == card.id }) {
                                        flashcards[index].isFlipped.toggle() // Flip only the tapped card
                                    }
                                }
                            }
                            .contextMenu {
                                Button(action: {
                                    selectedFlashcard = card
                                    newQuestion = card.question
                                    newAnswer = card.answer
                                    showEditCardForm = true // Show the edit form when "Edit" is tapped
                                }) {
                                    Label("Edit Flashcard", systemImage: "pencil")
                                }
                                Button(action: {
                                    deleteFlashcard(id: card.id)
                                }) {
                                    Label("Delete Flashcard", systemImage: "trash")
                                }
                            }
                        }
                        .padding(.bottom, 20)
                    }
                }

                // Button to show the form for adding a flashcard
                Button(action: {
                    showAddCardForm.toggle()
                }) {
                    Text("Add Flashcard")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 30)

                Spacer()
            }
            .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $showAddCardForm) {
                VStack {
                    Text("Add Flashcard")
                        .font(.title2)
                        .padding()

                    // Form for adding a flashcard
                    TextField("Enter Question", text: $newQuestion)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(8)
                        .foregroundColor(.white)

                    TextField("Enter Answer", text: $newAnswer)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(8)
                        .foregroundColor(.white)

                    Button(action: {
                        addFlashcard()
                        showAddCardForm = false
                    }) {
                        Text("Save Flashcard")
                            .font(.title2)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 20)

                    Spacer()
                }
                .padding()
                .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
            }
            .sheet(isPresented: $showEditCardForm) {
                VStack {
                    Text("Edit Flashcard")
                        .font(.title2)
                        .padding()

                    // Form for editing a flashcard
                    TextField("Enter Question", text: $newQuestion)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(8)
                        .foregroundColor(.white)

                    TextField("Enter Answer", text: $newAnswer)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(8)
                        .foregroundColor(.white)

                    Button(action: {
                        if let selectedFlashcard = selectedFlashcard {
                            editFlashcard(id: selectedFlashcard.id, question: newQuestion, answer: newAnswer)
                        }
                        showEditCardForm = false
                    }) {
                        Text("Save Changes")
                            .font(.title2)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 20)

                    Spacer()
                }
                .padding()
                .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
            }
            .onAppear {
                loadFlashcards()
            }
        }
    }
}

struct FlashCardsApp_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardsApp()
    }
}
