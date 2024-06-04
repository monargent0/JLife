//
//  UIFontMetrics+.swift
//  JLife
//
//  Created by OoO on 6/4/24.
//

import UIKit

extension UIFontMetrics {
  static func customFont(with name: String, of size: CGFloat, for style: UIFont.TextStyle) -> UIFont {
    let font = UIFont(name: name, size: size)!
    
    return UIFontMetrics(forTextStyle: style).scaledFont(for: font)
  }
}
