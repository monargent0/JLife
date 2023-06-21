//
//  CalendarHelper.swift
//  JLife
//
//  Created by 오정은 on 2022/11/11.
//

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
    
    // Month 표현 (1)
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M" // M : 1 ~ 12 / MM : 01 ~ 12
        return dateFormatter.string(from: date)
    }
    
    // Year 표현 (2022)
    func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    // 월의 총 일 수 ex) InPut: 10월 16일 -> Output: 10월 총 일수 : 31
    func daysInMonth(date:Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    // CURRENT DATE Today 일자 ex) Input: 10월 16일 -> Output: 16
    func dayOfMonth(date:Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    // 월의 첫날
    // components출력 : year: 2022 month: 11 isLeapMonth: false (윤달)
    // return 값 : 2022-10-31 15:00:00 +0000
    func firstOfMonth(date:Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
          
    // 월의 첫날이 몇번째 요일인지 Sun ~ Sat : 0 ~ 6 (-1 적용)
    func startWeekDay(date:Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
    // 이전달 총 일수
    func daysInPrevMonth(date:Date) -> Int {
        let prevDate = calendar.date(byAdding: .month, value: -1, to: date)!
        let range = calendar.range(of: .day, in: .month, for: prevDate)!
        return range.count
    }
    
    //--- View Part ---
    // 위 테두리
    func addTopBorder(stackview : UIStackView , borderWidth : Double , borderColor : CGColor){
        let topLine = CALayer()
        topLine.frame = CGRect(x: 0 , y: 0 , width: UIScreen.main.bounds.width , height: CGFloat(borderWidth) )
        // x,y : 시작 위치 & w,h : border 너비,두께
        // UIScreen.main.bounds.width /  stackview.bounds.size.width
        topLine.backgroundColor = borderColor // UIColor.darkGray.cgColor
        stackview.layer.masksToBounds = true // true : 내 영역(Layer) 이외 영역의 Sub Layer는 Draw 하지 않는다
        stackview.layer.addSublayer(topLine)
    }

}
