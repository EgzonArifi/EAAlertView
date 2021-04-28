//
//  EAButton.swift
//  EAAlertView
//
//  Created by Egzon Arifi on 8/10/18.
//  Copyright © 2018 Overjump. All rights reserved.
//

import Foundation
import UIKit

open class EAButton: UIButton {
    
    var actionType = EAActionType.none
    var target:AnyObject!
    var selector:Selector!
    var action:(()->Void)!
    var customBackgroundColor:UIColor?
    var customTextColor:UIColor?
    var initialTitle:String!
    var showTimeout:ShowTimeoutConfiguration?
    
    public struct ShowTimeoutConfiguration {
        let prefix: String
        let suffix: String
        
        public init(prefix: String = "", suffix: String = "") {
            self.prefix = prefix
            self.suffix = suffix
        }
    }
    
    public init() {
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override public init(frame:CGRect) {
        super.init(frame:frame)
    }
    
    internal lazy var spinner: EASpinnerLayer = {
        let spiner = EASpinnerLayer(frame: self.frame)
        self.layer.addSublayer(spiner)
        return spiner
    }()
    
    internal func collapseAnimation() {
        
        setTitle("", for: .normal)
        isUserInteractionEnabled = false
        
        let animaton = CABasicAnimation(keyPath: "bounds.size.width")
        animaton.fromValue = frame.width
        animaton.toValue =  frame.height
        animaton.duration = 0.1
        animaton.fillMode = CAMediaTimingFillMode.forwards
        animaton.isRemovedOnCompletion = false
        
        layer.add(animaton, forKey: animaton.keyPath)
        spinner.isHidden = false
        spinner.startAnimation()
    }
    
    internal func backToDefaults() {
        
        spinner.stopAnimation()
        setTitle(initialTitle, for: .normal)
        isUserInteractionEnabled = true
        
        let animaton = CABasicAnimation(keyPath: "bounds.size.width")
        animaton.fromValue = frame.height
        animaton.toValue = frame.width
        animaton.duration = 0.1
        animaton.fillMode = CAMediaTimingFillMode.forwards
        animaton.isRemovedOnCompletion = false
        
        layer.add(animaton, forKey: animaton.keyPath)
        spinner.isHidden = true
    }
    
    internal func shakeAnimation() {
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1, animations: {
                let transform = CGAffineTransform(translationX: 10, y: 0)
                self.transform = transform
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.1, animations: {
                let transform = CGAffineTransform(translationX: -7, y: 0)
                self.transform = transform
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.1, animations: {
                let transform = CGAffineTransform(translationX: 5, y: 0)
                self.transform = transform
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.1, animations: {
                let transform = CGAffineTransform(translationX: -3, y: 0)
                self.transform = transform
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.1, animations: {
                let transform = CGAffineTransform(translationX: 2, y: 0)
                self.transform = transform
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.1, animations: {
                let transform = CGAffineTransform(translationX: -1, y: 0)
                self.transform = transform
            })
        })
    }
    
    public func animate(animation: AnimationType) {
        
        switch animation {
            
        case .collapse:
            UIView.animate(withDuration: 0.1, animations: {
                self.layer.cornerRadius = self.frame.height/2
            }, completion: { (completion) in
                self.collapseAnimation()
            })
            
        case .expand:
            UIView.animate(withDuration: 0.1, animations: {
                self.layer.cornerRadius = 4
            }, completion: { (completion) in
                self.backToDefaults()
            })
            
        case .shake:
            shakeAnimation()
        }
    }
    
    public var gradientColors: [CGColor]? {
        willSet {
            gradientLayer.colors = newValue
        }
    }
    
    internal lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer(frame: self.frame)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }()
}
