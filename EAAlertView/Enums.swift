//
//  Enums.swift
//  EAAlertView
//
//  Created by Egzon Arifi on 8/10/18.
//  Copyright © 2018 Overjump. All rights reserved.
//

import Foundation

public enum EAAlertViewStyle {
    case success, error, notice, warning, info, edit, wait, question
    
    public var defaultColorInt: UInt {
        switch self {
        case .success:
            return 0x22B573
        case .error:
            return 0xC1272D
        case .notice:
            return 0x727375
        case .warning:
            return 0xFFD110
        case .info:
            return 0x2866BF
        case .edit:
            return 0xA429FF
        case .wait:
            return 0xD62DA5
        case .question:
            return 0x727375
        }
    }
}

// Animation Styles
public enum EAAnimationStyle {
    case noAnimation, topToBottom, bottomToTop, leftToRight, rightToLeft
}

// Action Types
public enum EAActionType {
    case none, selector, closure
}

public enum EAAlertButtonLayout {
    case horizontal, vertical
}
