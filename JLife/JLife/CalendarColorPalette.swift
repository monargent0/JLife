//
//  CalendarColorPalette.swift
//  JLife
//
//  Created by OoO on 5/18/24.
//

typealias Theme = (mainColor: String, border: String, kr: String)

enum CalendarColorPalette: String, CaseIterable {
  case Basic
  case Coral
  case Purple
  case Pink
  case Beige
  case Green
  case WarmGray
  case CoolGray
  case Blue
  case Yellow
  
  var theme: Theme {
    switch self {
    case .Basic:
      return ("BasicTheme", "BasicBorder", "기본")
    case .Coral:
      return ("CoralTheme", "CoralBorder", "다홍색")
    case .Purple:
      return ("PurpleTheme", "PurpleBorder", "보라색")
    case .Pink:
      return ("PinkTheme", "PinkBorder", "분홍색")
    case .Beige:
      return ("BeigeTheme", "BeigeBorder", "연갈색")
    case .Green:
      return ("GreenTheme", "GreenBorder", "연녹색")
    case .WarmGray:
      return ("WarmGrayTheme", "WarmGrayBorder", "적회색")
    case .CoolGray:
      return ("CoolGrayTheme", "CoolGrayBorder", "청회색")
    case .Blue:
      return ("BlueTheme", "BlueBorder", "하늘색")
    case .Yellow:
      return ("YellowTheme", "YellowBorder", "연노랑색")
    }
  }
}
