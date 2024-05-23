//
//  MonthlyBoxEntity+CoreDataProperties.swift
//  JLife
//
//  Created by OoO on 5/1/24.
//
//

import Foundation
import CoreData


extension MonthlyBoxEntity {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<MonthlyBoxEntity> {
    return NSFetchRequest<MonthlyBoxEntity>(entityName: "MonthlyBoxEntity")
  }
  
  @NSManaged public var id: UUID?
  @NSManaged public var date: String?
  @NSManaged public var title: String?
  @NSManaged public var content: String?
  
}

extension MonthlyBoxEntity : Identifiable {
  
}
