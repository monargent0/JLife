//
//  SeparatorView.swift
//  JLife
//
//  Created by Hyun A Song on 5/2/24.
//

import UIKit

final class SeparatorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = UIColor(resource: .customGray)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
