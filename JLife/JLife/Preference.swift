//
//  Preference.swift
//  JLife
//
//  Created by OoO on 6/4/24.
//

enum Preference {
  enum Bundle {
    case appVersion
    case weatherAPI
    
    var key: String {
      switch self {
      case .appVersion:
        "CFBundleShortVersionString"
      case .weatherAPI:
        "WEATHER_API_KEY"
      }
    }
  }
  
  enum UserDefaults {
    case launchedBefore
    case font
    case color
    
    var key: String {
      switch self {
      case .launchedBefore:
        "launchedVersion"
      case .font:
        "FontKey"
      case .color:
        "ColorKey"
      }
    }
  }
}
