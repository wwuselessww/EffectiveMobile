//
//  TaskEntity+CoreDataProperties.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 24.06.25.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var bodyText: String?
    @NSManaged public var completed: Bool
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?

}

extension TaskEntity : Identifiable {

}
