//
//  NSArrayTransformer.swift
//  StudyBuddy
//
//  Created by Brendan Dasilva on 2025-03-14.
//

import Foundation

@objc(NSArrayTransformer)
final class NSArrayTransformer: NSSecureUnarchiveFromDataTransformer {
    static let name = NSValueTransformerName(rawValue: String(describing: NSArrayTransformer.self))
    
    override static var allowedTopLevelClasses: [AnyClass] {
        return [NSArray.self]
    }
    
    public static func register() {
        let transformer = NSArrayTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
