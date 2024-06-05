//
//  CalendarColorPalette.swift
//  JLife
//
//  Created by OoO on 5/18/24.
//

typealias Theme = (mainColor: String, border: String, kr: String)

enum CalendarColorPalette: String, CaseIterable {
  case basic
  case coral
  case purple
  case pink
  case beige
  case green
  case warmGray
  case coolGray
  case blue
  case yellow
  
  var theme: Theme {
    switch self {
    case .basic:
      return ("BasicTheme", "BasicBorder", "기본")
    case .coral:
      return ("CoralTheme", "CoralBorder", "다홍색")
    case .purple:
      return ("PurpleTheme", "PurpleBorder", "보라색")
    case .pink:
      return ("PinkTheme", "PinkBorder", "분홍색")
    case .beige:
      return ("BeigeTheme", "BeigeBorder", "연갈색")
    case .green:
      return ("GreenTheme", "GreenBorder", "연녹색")
    case .warmGray:
      return ("WarmGrayTheme", "WarmGrayBorder", "적회색")
    case .coolGray:
      return ("CoolGrayTheme", "CoolGrayBorder", "청회색")
    case .blue:
      return ("BlueTheme", "BlueBorder", "하늘색")
    case .yellow:
      return ("YellowTheme", "YellowBorder", "연노랑색")
    }
  }
}
