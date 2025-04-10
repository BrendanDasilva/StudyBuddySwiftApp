//
//  StudyGroup.swift
//  StudyBuddy
//
//  Created by jessica lee on 2025-04-10.
//

import CoreData

@objc(StudyGroup)
public class StudyGroup: NSManagedObject {
    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var isMember: Bool
    @NSManaged public var members: Int16
    @NSManaged public var topics: [String]
}
