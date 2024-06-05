//
//  FontStyle.swift
//  JLife
//
//  Created by OoO on 6/4/24.
//

enum FontStyle {
  case surroundAirStyle
  case simplehaeStyle
  
  var name: String {
    switch self {
    case .surroundAirStyle:
      "Cafe24SsurroundAir"
    case .simplehaeStyle:
      "Cafe24Simplehae-v2.0"
    }
  }
}
