//
//  FontSize.swift
//  JLife
//
//  Created by OoO on 6/4/24.
//

import Foundation

enum FontSize {
    case custom(CGFloat)
    case headline1
    case headline2
    case headline3
    case title1
    case title2
    case title3
    case body1
    case body2
    case body3
    case label
    case caption
    
    var size: CGFloat {
        switch self {
        case .custom(let number):
            return number
        case .headline1:
            return 32
        case .headline2:
            return 28
        case .headline3:
            return 24
        case .title1:
            return 22
        case .title2:
            return 16
        case .title3:
            return 14
        case .body1:
            return 16
        case .body2:
            return 14
        case .body3:
            return 12
        case .label:
            return 14
        case .caption:
            return 12
        }
    }
}
