//
//  EAAlertViewResponder.swift
//  EAAlertView
//
//  Created by Egzon Arifi on 8/10/18.
//  Copyright © 2018 Overjump. All rights reserved.
//

import Foundation
import UIKit

// Allow alerts to be closed/renamed in a chainable manner
// Example: EAAlertView().showSuccess(self, title: "Test", subTitle: "Value").close()
open class EAAlertViewResponder {
    let alertview: EAAlertView
    
    // Initialisation and Title/Subtitle/Close functions
    public init(alertview: EAAlertView) {
        self.alertview = alertview
    }
    
    open func setTitle(_ title: String) {
        self.alertview.labelTitle.text = title
    }
    
    open func setSubTitle(_ subTitle: String?) {
        self.alertview.viewText.text = subTitle != nil ? subTitle : ""
    }
    
    open func close() {
        self.alertview.hideView()
    }
    
    open func setDismissBlock(_ dismissBlock: @escaping DismissBlock) {
        self.alertview.dismissBlock = dismissBlock
    }
}
