//
//  VerticalFillStackView.swift
//  JLife
//
//  Created by OoO on 6/9/24.
//

import UIKit

final class VerticalFillStackView: UIStackView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  init() {
    super.init(frame: .zero)
    
    spacing = 10
    axis = .vertical
    alignment = .fill
    distribution = .equalCentering
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
