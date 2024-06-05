//
//  UIFont+.swift
//  JLife
//
//  Created by OoO on 6/4/24.
//

import UIKit

extension UIFont {
  
  static func setUpFont(with name: String?, of size: CGFloat) -> UIFont {
    let fontName = name ?? FontStyle.surroundAirStyle.name
    guard let font = UIFont(name: fontName, size: size) else {
      fatalError("""
          Failed to load the "\(fontName)" font.
          Make sure the font file is included in the project and the font name is spelled correctly.
          """
      )
    }
    
    return font
  }
}
