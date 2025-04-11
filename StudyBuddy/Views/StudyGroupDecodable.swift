//
//  StudyGroup.swift
//  StudyBuddy
//
//  Created by jessica lee on 2025-04-10.
//

import Foundation

// This struct is used for decoding JSON from the backend
struct StudyGroupDecodable: Decodable {
    var id: String?  // UUID as String from backend
    var name: String?
    var features: [String]?
    var topics: [String]?
    var createdAt: String?  // You can convert this to Date when needed
    var members: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, features, topics, createdAt, members
    }
}
