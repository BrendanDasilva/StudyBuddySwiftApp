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
    @State private var selectedFlashcard: FlashCard? = nil
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    var groupId: String
    var body: some View {
        VStack {
            Spacer()
            
            Text("Flash Cards")
                .font(.custom("HelveticaNeue-Bold", size: 60))
                .foregroundColor(Color.white)
                .shadow(color: Color.gray, radius: 8, x: 0, y: 8)
                .multilineTextAlignment(.center)
                .padding(.top, 30)
            
            if flashcards.isEmpty {
                VStack(spacing: 10){
                    Spacer()
                    
                    Text("Add FlashCards.")
                        .font(.custom("Menlo-Bold", size: 16))
                        .background(Color.clear)
                        .shadow(color: Color(#colorLiteral(red: 0.13401145, green: 0.1061868557, blue: 0.2262137172, alpha: 0.7275455298)), radius: 4, x: -3, y: -3)
                        .foregroundColor(.white)
                    
                    Text("Tap the plus (+) button to add a new flashcard.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
            } else {
                ScrollView{
                    VStack(spacing: 20){
                        ForEach(flashcards) { card in
                            CardView(
                                flashcards: $flashcards,
                                card: card,
                                deleteAction: { id in
                                        deleteFlashcard(id: id)
                                }
                            )
                        }
                    }
                    .padding(.top, 20)
                }
            }
            Spacer()
            Button(action: {
                showAddCardForm.toggle()
            }) {
                Text("+")
                    .font(.custom("Menlo-Bold", size: 16))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.clear)
                    .foregroundColor(.white)
            }
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(#colorLiteral(red: 0.1701194298, green: 0.1297623498, blue: 0.2721540133, alpha: 1)), lineWidth: 2))
            .shadow(color: Color(#colorLiteral(red: 0.13401145, green: 0.1061868557, blue: 0.2262137172, alpha: 0.7275455298)), radius: 4, x: -3, y: -3)
            .foregroundColor(.white)
            .padding(.horizontal, 40)
            .padding(.bottom, 100)
        }
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $showAddCardForm) {
            
            AddEditFlashcardView(
                title: "Add Flashcard",
                question: $newQuestion,
                answer: $newAnswer,
                saveAction: {
                    addFlashcard()
                    showAddCardForm = false
                }
            )
        }
        .sheet(isPresented: $showAddCardForm){
            AddEditFlashcardView(
                title: "Edit Flashcard",
                question: $newQuestion,
                answer: $newAnswer,
                saveAction: {
                    if let selectedFlashcard = selectedFlashcard {
                        editFlashcard(id: selectedFlashcard.id, question: newQuestion, answer: newAnswer)
                    }
                    showEditCardForm = false
                }
            )
        }
        .onAppear{
            loadFlashcards()
        }
        .alert(isPresented: $showErrorAlert){
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    
    func loadFlashcards() {
        if let data = UserDefaults.standard.data(forKey: "flashcards") {
            let decoder = JSONDecoder()
            if let savedFlashcards = try? decoder.decode([FlashCard].self, from: data){
                flashcards = savedFlashcards
            }
        }
    }
    
    func saveFlashcards(){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(flashcards){
            UserDefaults.standard.set(encoded, forKey: "flashcards")
        }
    }
    func addFlashcard(){
        let newCard = FlashCard(id: UUID(), question: newQuestion, answer: newAnswer, visibility: "public", groupId: groupId, isFlipped: false)
        flashcards.append(newCard)
        saveFlashcards()
    }
    func deleteFlashcard(id: UUID){
        flashcards.removeAll { $0.id == id }
        saveFlashcards()
    }
    func editFlashcard(id: UUID, question: String, answer: String){
        if let index = flashcards.firstIndex(where: { $0.id == id }) {
            flashcards[index].question = question
            flashcards[index].answer = answer
            saveFlashcards()
        }
    }
}

struct CardView: View {
    @Binding var flashcards: [FlashCard]
    var card: FlashCard
    var deleteAction: (UUID) -> Void
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(card.isFlipped ? Color.green : Color.purple)
                .frame(height: 200)
                .shadow(radius: 5)
            
            Text(card.isFlipped ? card.answer : card.question)
                .font(.title2)
                .foregroundColor(.white)
                .padding()
        }
        .padding(.horizontal, 20)
        .onTapGesture {
            withAnimation{
                if let index = flashcards.firstIndex(where: { $0.id == card.id}) {
                    flashcards[index].isFlipped.toggle()
                }
            }
        }
        .contextMenu {
            Button(action: {
                
            }) {
                Label("Edit", systemImage: "pencil")
            }
            Button(action: {
                deleteAction(card.id)
            }) {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

struct AddEditFlashcardView: View {
    var title: String
    @Binding var question: String
    @Binding var answer: String
    var saveAction: () -> Void
    
    var body: some View {
        VStack{
            Text(title)
                .font(.title2)
                .padding()
            
            TextField("Enter Question", text: $question)
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(8)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            TextField("Enter Answer", text: $answer)
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(8)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            Button(action: {
                saveAction()
            }) {
                Text("Save")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
            .padding(.top, 20)
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding()
        .background(Color(hex: "8AACEA").edgesIgnoringSafeArea(.all))
    }
}
    struct FlashCardsApp_Previews: PreviewProvider {
        static var previews: some View {
            FlashCardsApp(groupId: "sample-group-id")
        }
    }

