//
//  DailyBoxEntity+CoreDataProperties.swift
//  JLife
//
//  Created by 오정은 on 4/30/24.
//
//

import Foundation
import CoreData


extension DailyBoxEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyBoxEntity> {
        return NSFetchRequest<DailyBoxEntity>(entityName: "DailyBoxEntity")
    }

    @NSManaged public var year: Int64
    @NSManaged public var month: Int64
    @NSManaged public var day: Int64
    @NSManaged public var content: String?
    @NSManaged public var id: UUID?

}

extension DailyBoxEntity : Identifiable {

}
