//
//  FontManager.swift
//  JLife
//
//  Created by Hyun A Song on 6/4/24.
//

import Foundation

struct FontManager {
  static let fontKey = "FontKey"
  
  static func getFont() -> String {
    if let font = UserDefaults.standard.value(forKey: fontKey) as? String {
      return font
    } else {
      return FontStyle.surroundAirStyle.name
    }
  }
  
  static func setFont(with font: String) {
    UserDefaults.standard.setValue(font, forKey: fontKey)
  }
}
