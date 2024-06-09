//
//  BodyLabel.swift
//  JLife
//
//  Created by OoO on 5/2/24.
//

import UIKit

final class BodyLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  init(for body: String) {
    super.init(frame: .zero)
    
    text = body
    textAlignment = .center
    textColor = UIColor(resource: .reversedSystem)
    adjustsFontForContentSizeCategory = true
    font = UIFontMetrics.customFont(with: AppFont.shared.style,
                                    of: FontSize.body1.size,
                                    for: .body)
  }
  
  init(for body: String, alignment: NSTextAlignment) {
    super.init(frame: .zero)
    
    text = body
    textAlignment = alignment
    textColor = UIColor(resource: .reversedSystem)
    adjustsFontForContentSizeCategory = true
    font = UIFontMetrics.customFont(with: AppFont.shared.style,
                                    of: FontSize.body1.size,
                                    for: .body)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
