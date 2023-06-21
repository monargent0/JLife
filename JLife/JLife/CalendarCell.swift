//
//  CalendarCell.swift
//  JLife
//
//  Created by 오정은 on 2023/06/22.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    // storyborad와 연결
    @IBOutlet weak var lblDay: UILabel!
    
    // Layer Shape (원)
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    
    // Prepare For Reuse (초기화)
    override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundColor = .clear
    }
}
