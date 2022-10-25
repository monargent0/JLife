//
//  CalendarCell.swift
//  CalenderApp_J
//
//  Created by 오정은 on 2022/10/16.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    @IBOutlet weak var lblDay: UILabel!
    
    // 레이어 모양 변경 (원형으로)
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.size.width / 2 // 반으로 나눠줘야 원형이 된다.
    }
    
    // UICollectionView의 Cell은 reusable이므로 재생성에 사용되는 Cell의 속성이 유지됩니다.
    // 에러방지를 위해 매번 Reuse 전에 기본값을 설정합니다.
    override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundColor = .clear
    }
}
