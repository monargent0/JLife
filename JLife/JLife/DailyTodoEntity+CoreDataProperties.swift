//
//  DailyTodoEntity+CoreDataProperties.swift
//  JLife
//
//  Created by OoO on 5/1/24.
//
//

import Foundation
import CoreData


extension DailyTodoEntity {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyTodoEntity> {
    return NSFetchRequest<DailyTodoEntity>(entityName: "DailyTodoEntity")
  }
  
  @NSManaged public var id: UUID?
  @NSManaged public var date: String?
  @NSManaged public var contentTime: String?
  @NSManaged public var content: String?
  @NSManaged public var complete: Bool
  @NSManaged public var score: Double
  
}

extension DailyTodoEntity : Identifiable {
  
}
