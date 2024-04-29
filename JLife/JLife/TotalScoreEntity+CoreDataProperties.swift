//
//  TotalScoreEntity+CoreDataProperties.swift
//  JLife
//
//  Created by 오정은 on 4/30/24.
//
//

import Foundation
import CoreData


extension TotalScoreEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TotalScoreEntity> {
        return NSFetchRequest<TotalScoreEntity>(entityName: "TotalScoreEntity")
    }

    @NSManaged public var year: Int64
    @NSManaged public var month: Int64
    @NSManaged public var day: Int64
    @NSManaged public var totalScore: Int64
    @NSManaged public var id: UUID?

}

extension TotalScoreEntity : Identifiable {

}
