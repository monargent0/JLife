//
//  TintedButton.swift
//  JLife
//
//  Created by OoO on 6/9/24.
//

import UIKit

final class TintedButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  init(title: String, color: UIColor) {
    super.init(frame: .zero)
    
    configuration = .tinted()
    setTitle(title, for: .normal)
    titleLabel?.font = UIFont.setUpFont(with: AppFont.shared.style,
                                        of: FontSize.body1.size)
    tintColor = color
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
