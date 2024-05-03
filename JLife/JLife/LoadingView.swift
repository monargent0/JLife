//
//  LoadingView.swift
//  JLife
//
//  Created by OoO on 5/3/24.
//

import UIKit
import Gifu

final class LoadingView: UIView {
    
    private var gifImageView: GIFImageView = {
        let image = GIFImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureBackgroundColor()
        configureUI()
        configureImage()
        setUpGifImageConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI
    private func configureBackgroundColor(){
        backgroundColor = .systemBackground
    }
    
    private func configureUI(){
        addSubview(gifImageView)
    }
    
    private func configureImage(){
        gifImageView.animate(withGIFNamed: "JLifeLogo",
                                 loopCount: 1,
                             loopBlock: {
            NotificationCenter.default.post(name: NSNotification.Name("isGifDone"), 
                                            object: nil)
            
        })
    }
    
    // MARK: - Constraints
    private func setUpGifImageConstraints(){
        NSLayoutConstraint.activate([
            gifImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            gifImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            gifImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            gifImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}
