//
//  FlashCard.swift
//  StudyBuddy
//
//

import Foundation

// Define the FlashCard structure
struct FlashCard: Identifiable, Codable {
    var id: UUID
    var question: String
    var answer: String
    var visibility: String
    var groupId: String
    var isFlipped: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case question
        case answer
        case visibility
        case groupId
        case isFlipped
    }
}
