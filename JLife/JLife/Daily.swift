//
//  Daily.swift
//  JLife
//
//  Created by OoO on 2023/07/07.
//

import Foundation

class Daily{
    var id: Int
    var date: String?
    var content: String?
    
    init(id: Int, date: String? = nil, content: String? = nil) {
        self.id = id
        self.date = date
        self.content = content
    }
}
