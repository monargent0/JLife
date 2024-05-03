//
//  CalendarBuilder.swift
//  JLife
//
//  Created by OoO on 2023/06/22.
//

import Foundation
import UIKit

final class CalendarBuilder{
    
    let calendar = Calendar.current
    
    // 다음달
    func plusMonth(date:Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    // 이전달
    func minusMonth(date:Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    // Day 표현
    func dayString(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d" // d : 1~31 dd: 01~31
        return dateFormatter.string(from: date)
    }
    // Month 표현
    func monthString(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M" // M : 1~12 , MM : 01~12
        return dateFormatter.string(from: date)
    }
    // Year 표현
    func yearString(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy" // 202n
        return dateFormatter.string(from: date)
    }
    // 월의 총 일 수 (Input : 10월 16일 - Output : 10월 일수, 31)
    func daysInMonth(date:Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    // Current 날짜 Day
    func dayOfMonth(date:Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    // 월의 첫날
    func firstOfMonth(date:Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    /* components 출력 = year : 2023 , month : 11 , isLeapMonth : false (윤달)
     return 값 = 2023-10-31 15:00:00 +0000  (애플개발지역기준인듯?) */
    
    // 월의 첫날의 요일 순서
    func startWeekDay(date:Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    /* Sun ~ Sat : 0 ~ 6 (-1 적용됨) */
    
    // 이전달 총 일수
    func daysInPrevMonth(date:Date) -> Int {
        let prevDate = calendar.date(byAdding: .month, value: -1, to: date)!
        let range = calendar.range(of: .day, in: .month, for: prevDate)!
        return range.count
    }
    
}
