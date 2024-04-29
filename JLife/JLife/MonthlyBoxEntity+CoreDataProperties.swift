//
//  MonthlyBoxEntity+CoreDataProperties.swift
//  JLife
//
//  Created by 오정은 on 4/30/24.
//
//

import Foundation
import CoreData


extension MonthlyBoxEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MonthlyBoxEntity> {
        return NSFetchRequest<MonthlyBoxEntity>(entityName: "MonthlyBoxEntity")
    }

    @NSManaged public var year: Int64
    @NSManaged public var month: Int64
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var id: UUID?

}

extension MonthlyBoxEntity : Identifiable {

}
