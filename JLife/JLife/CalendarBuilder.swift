//
//  CalendarBuilder.swift
//  JLife
//
//  Created by OoO on 2023/06/22.
//

import Foundation
import UIKit

final class CalendarBuilder {
  
  let calendar = Calendar.current
  
  func plusMonth(date: Date) -> Date {
    return calendar.date(byAdding: .month, value: 1, to: date)!
  }
  
  func minusMonth(date: Date) -> Date {
    return calendar.date(byAdding: .month, value: -1, to: date)!
  }
  
  func dayString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d"
    return dateFormatter.string(from: date)
  }
  
  func monthString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "M"
    return dateFormatter.string(from: date)
  }
  
  func yearString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    return dateFormatter.string(from: date)
  }
  
  func daysInMonth(date: Date) -> Int {
    let range = calendar.range(of: .day, in: .month, for: date)!
    return range.count
  }
  
  func dayOfMonth(date: Date) -> Int {
    let components = calendar.dateComponents([.day], from: date)
    return components.day!
  }
  
  func firstOfMonth(date: Date) -> Date {
    let components = calendar.dateComponents([.year, .month], from: date)
    return calendar.date(from: components)!
  }
  
  func startWeekDay(date: Date) -> Int {
    let components = calendar.dateComponents([.weekday], from: date)
    return components.weekday! - 1
  }
  
  func daysInPrevMonth(date: Date) -> Int {
    let prevDate = calendar.date(byAdding: .month, value: -1, to: date)!
    let range = calendar.range(of: .day, in: .month, for: prevDate)!
    return range.count
  }
}
