//
//  HorizontalSatckView.swift
//  JLife
//
//  Created by OoO on 5/2/24.
//

import UIKit

class HorizontalSatckView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: .zero)
        
        axis = .horizontal
        alignment = .center
        distribution = .equalSpacing
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
