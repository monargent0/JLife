//
//  DayLabel.swift
//  JLife
//
//  Created by OoO on 5/2/24.
//

import UIKit

class DayLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(for day: String) {
        super.init(frame: .zero)
        
        text = day
        textAlignment = .center
        textColor = UIColor(resource: .reversedSystem)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
