//
//  TotalScoreEntity+CoreDataProperties.swift
//  JLife
//
//  Created by OoO on 5/1/24.
//
//

import Foundation
import CoreData


extension TotalScoreEntity {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<TotalScoreEntity> {
    return NSFetchRequest<TotalScoreEntity>(entityName: "TotalScoreEntity")
  }
  
  @NSManaged public var id: UUID?
  @NSManaged public var date: String?
  @NSManaged public var totalScore: Int64
  
}

extension TotalScoreEntity: Identifiable {
  
}
