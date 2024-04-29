//
//  DailyTodoEntity+CoreDataProperties.swift
//  JLife
//
//  Created by 오정은 on 4/30/24.
//
//

import Foundation
import CoreData


extension DailyTodoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyTodoEntity> {
        return NSFetchRequest<DailyTodoEntity>(entityName: "DailyTodoEntity")
    }

    @NSManaged public var year: Int64
    @NSManaged public var month: Int64
    @NSManaged public var day: Int64
    @NSManaged public var contentTime: String?
    @NSManaged public var content: String?
    @NSManaged public var complete: Bool
    @NSManaged public var score: Double
    @NSManaged public var id: UUID?

}

extension DailyTodoEntity : Identifiable {

}
