//
//  LogoGifView.swift
//  JLife
//
//  Created by OoO on 5/3/24.
//

import UIKit
import Gifu

class LogoGifView: UIView {
    
    private var gifImageView: GIFImageView = {
        let image = GIFImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpBackgroundColor()
        configureUI()
        setGifImage()
        setGifLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpBackgroundColor(){
        backgroundColor = .white
    }
    
    private func configureUI(){
        addSubview(gifImageView)
    }
    
    private func setGifImage(){
        gifImageView.animate(withGIFNamed: "JLifeLogo",
                                 loopCount: 1,
                             loopBlock: {
            NotificationCenter.default.post(name: NSNotification.Name("isGifDone"), object: nil)
            
        })
    }
    
    private func setGifLayouts(){
        gifImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        gifImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        gifImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        gifImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }

}
