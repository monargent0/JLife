//
//  TitleLabel.swift
//  JLife
//
//  Created by OoO on 6/9/24.
//

import UIKit

final class TitleLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  init(for title: String) {
    super.init(frame: .zero)
    
    text = title
    textAlignment = .center
    textColor = UIColor(resource: .reversedSystem)
    adjustsFontForContentSizeCategory = true
    font = UIFontMetrics.customFont(with: AppFont.shared.style,
                                    of: FontSize.title1.size,
                                    for: .title1)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
