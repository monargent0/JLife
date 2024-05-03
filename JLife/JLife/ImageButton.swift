//
//  ImageButton.swift
//  JLife
//
//  Created by OoO on 5/2/24.
//

import UIKit

final class ImageButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(with imageName: String) {
        super.init(frame: .zero)
        
        let image = UIImage(systemName: imageName,
                             withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        
        setImage(image, for: .normal)
        tintColor = UIColor(resource: .reversedSystem)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
