import Foundation
import UIKit

class CalenderHelper{
    
    let calendar = Calendar.current
    
    // 다음달
    func plusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    // 이전달
    func minusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    // Month 표현 (1월)
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US") // 영어로 표현하기 위함
//        dateFormatter.dateFormat = "MMMM" // Full name ex) December
        dateFormatter.dateFormat = "M" // M : 1 ~ 12 / MM : 01 ~ 12
        return dateFormatter.string(from: date)
    }
    // Year 표현 (2022)
    func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    // 월 일수 ex) InPut 10월 16일 -> Output 10월 총 일수 : 31
    func daysInMonth(date:Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    // Today 일자 ex) Input 10월 16일 -> Output 16
    func dayOfMonth(date:Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    // 월의 첫날  print(components) = year: 2022 month: 10 isLeapMonth: false
    func firstOfMonth(date:Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    // 첫날이 언제인지 sun~sat : 0~6
    func weekDay(date:Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
    // 전달이 몇일인지
    func prevDays(date:Date) -> Int {
        let prevDate = calendar.date(byAdding: .month, value: -1, to: date)!
        let range = calendar.range(of: .day, in: .month, for: prevDate)!
        return range.count
    }
}
