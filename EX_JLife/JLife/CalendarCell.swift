//
//  CalendarCell.swift
//  JLife
//
//  Created by 오정은 on 2022/11/11.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    @IBOutlet weak var lblDay: UILabel!
    
    // Layer Shape
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    // Prepare For Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundColor = .clear
    }
    
}
