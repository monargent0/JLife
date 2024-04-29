//
//  TotalScore.swift
//  JLife
//
//  Created by OoO on 2023/07/11.
//

import Foundation

class TotalScore {
    var id:Int?
    var date:String?
    var day:String?
    var score:Int?
    
    init(id: Int? = nil, date: String? = nil, day: String? = nil, score: Int? = nil) {
        self.id = id
        self.date = date
        self.day = day
        self.score = score
    }
}
