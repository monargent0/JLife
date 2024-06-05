//
//  DailyBoxEntity+CoreDataProperties.swift
//  JLife
//
//  Created by OoO on 5/1/24.
//
//

import Foundation
import CoreData


extension DailyBoxEntity {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyBoxEntity> {
    return NSFetchRequest<DailyBoxEntity>(entityName: "DailyBoxEntity")
  }
  
  @NSManaged public var id: UUID?
  @NSManaged public var date: String?
  @NSManaged public var content: String?
  
}

extension DailyBoxEntity: Identifiable {
  
}
