//
//  Todo.swift
//  JLife
//
//  Created by OoO on 2023/07/07.
//

import Foundation

class Todo {
  var id: Int
  var date: String?
  var time: String?
  var content: String?
  var complete: Int?
  var score: Float?
  
  init(id: Int, date: String? = nil, time: String? = nil, content: String? = nil, complete: Int? = nil, score: Float? = nil) {
    self.id = id
    self.date = date
    self.time = time
    self.content = content
    self.complete = complete
    self.score = score
  }
}
