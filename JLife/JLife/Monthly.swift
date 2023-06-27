//
//  Monthly.swift
//  JLife
//
//  Created by 오정은 on 2023/06/25.
//

import Foundation

class Monthly{
    var id: Int
    var year: Int?
    var month: Int?
    var title: String?
    var content: String?
    
    init(id: Int, year: Int? = nil, month: Int? = nil, title: String? = nil, content: String? = nil) {
        self.id = id
        self.year = year
        self.month = month
        self.title = title
        self.content = content
    }
}
