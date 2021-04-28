//
//  EAAlertView.swift
//  EAAlertView
//
//  Created by Egzon Arifi on 8/10/18.
//  Copyright © 2018 Overjump. All rights reserved.
//

import Foundation
import UIKit

let kCircleHeightBackground: CGFloat = 62.0
let uniqueTag: Int = Int(arc4random() % UInt32(Int32.max))
let uniqueAccessibilityIdentifier: String = "EAAlertView"

public typealias DismissBlock = () -> Void

open class EAAlertView: UIViewController {
    
    public struct EAAppearance {
        let kDefaultShadowOpacity: CGFloat
        let kCircleTopPosition: CGFloat
        let kCircleBackgroundTopPosition: CGFloat
        let kCircleHeight: CGFloat
        let kCircleIconHeight: CGFloat
        let kTitleHeight:CGFloat
        let kTitleMinimumScaleFactor: CGFloat
        let kWindowWidth: CGFloat
        var kWindowHeight: CGFloat
        var kTextHeight: CGFloat
        let kTextFieldHeight: CGFloat
        let kTextViewdHeight: CGFloat
        let kButtonHeight: CGFloat
        let circleBackgroundColor: UIColor
        let contentViewColor: UIColor
        let contentViewBorderColor: UIColor
        let titleColor: UIColor
        let subTitleColor: UIColor
        
        let margin: Margin
        /// Margin for EAAlertView.
        public struct Margin {
            //vertical
            
            /// The spacing between title's top and window's top.
            public var titleTop: CGFloat
            /// The spacing between textView/customView's bottom and first button's top.
            public var textViewBottom: CGFloat
            /// The spacing between buttons.
            public var buttonSpacing: CGFloat
            /// The spacing between textField.
            public var textFieldSpacing: CGFloat
            /// The last button's bottom margin against alertView's bottom
            public var bottom: CGFloat
            
            //Horizontal
            /// The subView's horizontal margin.
            public var horizontal: CGFloat = 12
            
            public init(titleTop: CGFloat = 30,
                        textViewBottom: CGFloat = 20,
                        buttonSpacing: CGFloat = 10,
                        textFieldSpacing: CGFloat = 15,
                        bottom: CGFloat = 14,
                        horizontal: CGFloat = 12) {
                self.titleTop = titleTop
                self.textViewBottom = textViewBottom
                self.buttonSpacing = buttonSpacing
                self.textFieldSpacing = textFieldSpacing
                self.bottom = bottom
                self.horizontal = horizontal
            }
        }
        
        // Fonts
        let kTitleFont: UIFont
        let kTextFont: UIFont
        let kButtonFont: UIFont
        
        // UI Options
        var disableTapGesture: Bool
        var showCloseButton: Bool
        var showCircularIcon: Bool
        var shouldAutoDismiss: Bool // Set this false to 'Disable' Auto hideView when EAButton is tapped
        var contentViewCornerRadius : CGFloat
        var fieldCornerRadius : CGFloat
        var buttonCornerRadius : CGFloat
        var dynamicAnimatorActive : Bool
        var buttonsLayout: EAAlertButtonLayout
        
        // Actions
        var hideWhenBackgroundViewIsTapped: Bool
        
        // Activity indicator
        var activityIndicatorStyle: UIActivityIndicatorView.Style
        
        public init(kDefaultShadowOpacity: CGFloat = 0.7, kCircleTopPosition: CGFloat = 0.0, kCircleBackgroundTopPosition: CGFloat = 6.0, kCircleHeight: CGFloat = 56.0, kCircleIconHeight: CGFloat = 20.0, kTitleHeight:CGFloat = 25.0,  kWindowWidth: CGFloat = UIScreen.main.bounds.width*0.88 , kWindowHeight: CGFloat = 178.0, kTextHeight: CGFloat = 90.0, kTextFieldHeight: CGFloat = 30.0, kTextViewdHeight: CGFloat = 80.0, kButtonHeight: CGFloat = 35.0, kTitleFont: UIFont = UIFont.boldSystemFont(ofSize: 32), kTitleMinimumScaleFactor: CGFloat = 1.0, kTextFont: UIFont = UIFont.systemFont(ofSize: 14), kButtonFont: UIFont = UIFont.boldSystemFont(ofSize: 14), showCloseButton: Bool = true, showCircularIcon: Bool = true, shouldAutoDismiss: Bool = true, contentViewCornerRadius: CGFloat = 5.0, fieldCornerRadius: CGFloat = 3.0, buttonCornerRadius: CGFloat = 6.0, hideWhenBackgroundViewIsTapped: Bool = false, circleBackgroundColor: UIColor = UIColor.white, contentViewColor: UIColor = UIColorFromRGB(0xFFFFFF), contentViewBorderColor: UIColor = UIColorFromRGB(0xCCCCCC), titleColor: UIColor = UIColor.black, subTitleColor: UIColor = UIColorFromRGB(0x4D4D4D), margin: Margin = Margin(), dynamicAnimatorActive: Bool = false, disableTapGesture: Bool = false, buttonsLayout: EAAlertButtonLayout = .vertical, activityIndicatorStyle: UIActivityIndicatorView.Style = .white) {
            
            self.kDefaultShadowOpacity = kDefaultShadowOpacity
            self.kCircleTopPosition = kCircleTopPosition
            self.kCircleBackgroundTopPosition = kCircleBackgroundTopPosition
            self.kCircleHeight = kCircleHeight
            self.kCircleIconHeight = kCircleIconHeight
            self.kTitleHeight = kTitleHeight
            self.kWindowWidth = kWindowWidth
            self.kWindowHeight = kWindowHeight
            self.kTextHeight = kTextHeight
            self.kTextFieldHeight = kTextFieldHeight
            self.kTextViewdHeight = kTextViewdHeight
            self.kButtonHeight = kButtonHeight
            self.circleBackgroundColor = circleBackgroundColor
            self.contentViewColor = contentViewColor
            self.contentViewBorderColor = contentViewBorderColor
            self.titleColor = titleColor
            self.subTitleColor = subTitleColor
            
            self.margin = margin
            
            self.kTitleFont = kTitleFont
            self.kTitleMinimumScaleFactor = kTitleMinimumScaleFactor
            self.kTextFont = kTextFont
            self.kButtonFont = kButtonFont
            
            self.disableTapGesture = disableTapGesture
            self.showCloseButton = showCloseButton
            self.showCircularIcon = showCircularIcon
            self.shouldAutoDismiss = shouldAutoDismiss
            self.contentViewCornerRadius = contentViewCornerRadius
            self.fieldCornerRadius = fieldCornerRadius
            self.buttonCornerRadius = buttonCornerRadius
            
            self.hideWhenBackgroundViewIsTapped = hideWhenBackgroundViewIsTapped
            self.dynamicAnimatorActive = dynamicAnimatorActive
            self.buttonsLayout = buttonsLayout
            
            self.activityIndicatorStyle = activityIndicatorStyle
        }
        
        mutating func setkWindowHeight(_ kWindowHeight:CGFloat) {
            self.kWindowHeight = kWindowHeight
        }
        
        mutating func setkTextHeight(_ kTextHeight:CGFloat) {
            self.kTextHeight = kTextHeight
        }
    }
    
    public struct EATimeoutConfiguration {
        
        public typealias ActionType = () -> Void
        
        var value: TimeInterval
        let action: ActionType
        
        mutating func increaseValue(by: Double) {
            self.value = value + by
        }
        
        public init(timeoutValue: TimeInterval, timeoutAction: @escaping ActionType) {
            self.value = timeoutValue
            self.action = timeoutAction
        }
        
    }
    
    var appearance: EAAppearance!
    
    // UI Colour
    var viewColor = UIColor()
    
    // UI Options
    open var iconTintColor: UIColor?
    open var customSubview : UIView?
    
    // Members declaration
    var baseView = UIView()
    var labelTitle = UILabel()
    var viewText = UITextView()
    var contentView = UIView()
    var circleBG = UIView(frame:CGRect(x:0, y:0, width:kCircleHeightBackground, height:kCircleHeightBackground))
    var circleView = UIView()
    open var circleButton = UIButton()
    var circleIconView = UIView()
    var timeout: EATimeoutConfiguration?
    var showTimeoutTimer: Timer?
    var timeoutTimer: Timer?
    var dismissBlock : DismissBlock?
    fileprivate var inputs = [UITextField]()
    fileprivate var input = [UITextView]()
    internal var buttons = [EAButton]()
    fileprivate var selfReference: EAAlertView?
    
    public init(appearance: EAAppearance) {
        self.appearance = appearance
        super.init(nibName:nil, bundle:nil)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    required public init() {
        appearance = EAAppearance()
        super.init(nibName:nil, bundle:nil)
        setup()
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        if appearance == nil {
            appearance = EAAppearance()
        }
        
        super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
    }
    
    fileprivate func setup() {
        // Set up main view
        view.frame = UIScreen.main.bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleWidth]
        view.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:appearance.kDefaultShadowOpacity)
        view.addSubview(baseView)
        // Base View
        baseView.frame = view.frame
        baseView.addSubview(contentView)
        // Content View
        contentView.layer.cornerRadius = appearance.contentViewCornerRadius
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.5
        contentView.addSubview(labelTitle)
        contentView.addSubview(viewText)
        // Circle View
        circleBG.backgroundColor = appearance.circleBackgroundColor
        circleBG.layer.cornerRadius = 6//circleBG.frame.size.height / 2
        baseView.addSubview(circleBG)
        circleBG.addSubview(circleView)
        let x = (kCircleHeightBackground - appearance.kCircleHeight) / 2
        circleView.frame = CGRect(x:x, y:x+appearance.kCircleTopPosition, width:contentView.frame.width, height:appearance.kCircleHeight)
        //circleView.layer.cornerRadius = circleView.frame.size.height / 2
        // Title
        labelTitle.numberOfLines = 0
        labelTitle.textAlignment = .center
        labelTitle.font = appearance.kTitleFont
        if(appearance.kTitleMinimumScaleFactor < 1){
            labelTitle.minimumScaleFactor = appearance.kTitleMinimumScaleFactor
            labelTitle.adjustsFontSizeToFitWidth = true
        }
        labelTitle.frame = CGRect(x:appearance.margin.horizontal, y:appearance.margin.titleTop, width: subViewsWidth, height:appearance.kTitleHeight)
        // View text
        viewText.isEditable = false
        viewText.isSelectable = false
        viewText.textAlignment = .center
        viewText.textContainerInset = UIEdgeInsets.zero
        viewText.textContainer.lineFragmentPadding = 0;
        viewText.font = appearance.kTextFont
        // Colours
        viewColor = .white
        contentView.backgroundColor = appearance.contentViewColor
        viewText.backgroundColor = appearance.contentViewColor
        labelTitle.textColor = appearance.titleColor
        viewText.textColor = appearance.subTitleColor
        contentView.layer.borderColor = appearance.contentViewBorderColor.cgColor
        //Gesture Recognizer for tapping outside the textinput
        if appearance.disableTapGesture == false {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EAAlertView.tapped(_:)))
            tapGesture.numberOfTapsRequired = 1
            self.view.addGestureRecognizer(tapGesture)
        }
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let rv = UIApplication.shared.keyWindow! as UIWindow
        let sz = rv.frame.size
        
        // Set background frame
        view.frame.size = sz
        
        let defaultTopOffset: CGFloat = 32
        
        // get actual height of title text
        var titleActualHeight: CGFloat = 0
        if let title = labelTitle.text {
            titleActualHeight = title.heightWithConstrainedWidth(width: subViewsWidth, font: labelTitle.font) + 10
            // get the larger height for the title text
            titleActualHeight = (titleActualHeight > appearance.kTitleHeight ? titleActualHeight : appearance.kTitleHeight)
        }
        
        // computing the right size to use for the textView
        let maxHeight = sz.height - 100 // max overall height
        var consumedHeight = CGFloat(0)
        consumedHeight += (titleActualHeight > 0 ? appearance.margin.titleTop + titleActualHeight : defaultTopOffset)
        consumedHeight += appearance.margin.bottom
        
        let buttonMargin = appearance.margin.buttonSpacing
        let textFieldMargin = appearance.margin.textFieldSpacing
        if appearance.buttonsLayout == .vertical {
            consumedHeight += appearance.kButtonHeight * CGFloat(buttons.count)
            consumedHeight += buttonMargin * (CGFloat(buttons.count) - 1)
        } else {
            consumedHeight += appearance.kButtonHeight
        }
        consumedHeight += (appearance.kTextFieldHeight + textFieldMargin) * CGFloat(inputs.count)
        consumedHeight += appearance.kTextViewdHeight * CGFloat(input.count)
        let maxViewTextHeight = maxHeight - consumedHeight
        let viewTextWidth = subViewsWidth
        var viewTextHeight = appearance.kTextHeight
        
        // Check if there is a custom subview and add it over the textview
        if let customSubview = customSubview {
            viewTextHeight = min(customSubview.frame.height, maxViewTextHeight)
            viewText.text = ""
            viewText.addSubview(customSubview)
        } else if viewText.text.isEmpty {
            viewTextHeight = 0
        } else {
            // computing the right size to use for the textView
            let suggestedViewTextSize = viewText.sizeThatFits(CGSize(width: viewTextWidth, height: CGFloat.greatestFiniteMagnitude))
            viewTextHeight = min(suggestedViewTextSize.height, maxViewTextHeight)
            
            // scroll management
            if (suggestedViewTextSize.height > maxViewTextHeight) {
                viewText.isScrollEnabled = true
            } else {
                viewText.isScrollEnabled = false
            }
        }
        
        var windowHeight = consumedHeight + viewTextHeight
        windowHeight += viewText.text.isEmpty ? 0 : appearance.margin.textViewBottom // only viewText.text is not empty should have margin.
        
        // Set frames
        let x = (sz.width - appearance.kWindowWidth) / 2
        var y = (sz.height - windowHeight - (appearance.kCircleHeight / 8)) / 2
        contentView.frame = CGRect(x:x, y:y, width:appearance.kWindowWidth, height:windowHeight)
        contentView.layer.cornerRadius = 8//appearance.contentViewCornerRadius
        y -= kCircleHeightBackground * 0.6
        //x = (sz.width - kCircleHeightBackground) / 2
        circleBG.frame = CGRect(x:x, y:y-appearance.kCircleBackgroundTopPosition, width:appearance.kWindowWidth, height:kCircleHeightBackground)
        
        //adjust Title frame based on circularIcon show/hide flag
        //        let titleOffset : CGFloat = appearance.showCircularIcon ? 0.0 : -12.0
        let titleOffset: CGFloat = 0
        labelTitle.frame = labelTitle.frame.offsetBy(dx: 0, dy: titleOffset)
        
        // Subtitle
        y = titleActualHeight > 0 ? appearance.margin.titleTop + titleActualHeight + titleOffset : defaultTopOffset
        viewText.frame = CGRect(x:appearance.margin.horizontal, y:y, width: viewTextWidth, height:viewTextHeight)
        // Text fields
        y += viewTextHeight
        y += viewText.text.isEmpty ? 0 : appearance.margin.textViewBottom // only viewText.text is not empty should have margin.
        
        for txt in inputs {
            txt.frame = CGRect(x:appearance.margin.horizontal, y:y, width:subViewsWidth, height:appearance.kTextFieldHeight)
            txt.layer.cornerRadius = appearance.fieldCornerRadius
            y += appearance.kTextFieldHeight + textFieldMargin
        }
        for txt in input {
            txt.frame = CGRect(x:appearance.margin.horizontal, y:y, width:subViewsWidth, height:appearance.kTextViewdHeight - appearance.margin.textViewBottom)
            //txt.layer.cornerRadius = fieldCornerRadius
            y += appearance.kTextViewdHeight
        }
        // Buttons
        var buttonX = appearance.margin.horizontal
        switch appearance.buttonsLayout {
        case .vertical:
            for btn in buttons {
                btn.frame = CGRect(x:buttonX, y:y, width:subViewsWidth, height:appearance.kButtonHeight)
                btn.layer.cornerRadius = appearance.buttonCornerRadius
                y += appearance.kButtonHeight + buttonMargin
            }
        case .horizontal:
            let numberOfButton = CGFloat(buttons.count)
            let buttonsSpace = numberOfButton >= 1 ? CGFloat(10) * (numberOfButton - 1) : 0
            let widthEachButton = (subViewsWidth - buttonsSpace) / numberOfButton
            for btn in buttons {
                btn.frame = CGRect(x:buttonX, y:y, width: widthEachButton, height:appearance.kButtonHeight)
                btn.layer.cornerRadius = appearance.buttonCornerRadius
                buttonX += widthEachButton
                buttonX += buttonsSpace
            }
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(EAAlertView.keyboardWillShow(_:)), name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(EAAlertView.keyboardWillHide(_:)), name:UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override open func touchesEnded(_ touches:Set<UITouch>, with event:UIEvent?) {
        if event?.touches(for: view)?.count > 0 {
            view.endEditing(true)
        }
    }
    
    open func addTextField(_ title:String?=nil)->UITextField {
        // Update view height
        appearance.setkWindowHeight(appearance.kWindowHeight + appearance.kTextFieldHeight)
        // Add text field
        let txt = UITextField()
        txt.borderStyle = UITextField.BorderStyle.roundedRect
        txt.font = appearance.kTextFont
        txt.autocapitalizationType = UITextAutocapitalizationType.words
        txt.clearButtonMode = UITextField.ViewMode.whileEditing
        
        txt.layer.masksToBounds = true
        txt.layer.borderWidth = 1.0
        
        if title != nil {
            txt.placeholder = title!
        }
        
        contentView.addSubview(txt)
        inputs.append(txt)
        return txt
    }
    
    open func addTextView()->UITextView {
        // Update view height
        appearance.setkWindowHeight(appearance.kWindowHeight + appearance.kTextViewdHeight)
        // Add text view
        let txt = UITextView()
        // No placeholder with UITextView but you can use KMPlaceholderTextView library
        txt.font = appearance.kTextFont
        //txt.autocapitalizationType = UITextAutocapitalizationType.Words
        //txt.clearButtonMode = UITextFieldViewMode.WhileEditing
        txt.isEditable = false
        txt.layer.masksToBounds = true
        txt.layer.borderWidth = 0.0
        txt.isEditable = false
        contentView.addSubview(txt)
        input.append(txt)
        return txt
    }
    
    @discardableResult
    open func addButton(backgroundImage:UIImage? = nil ,_ title:String, backgroundColor:UIColor? = nil, textColor:UIColor? = nil, showTimeout:EAButton.ShowTimeoutConfiguration? = nil, action:@escaping ()->Void)->EAButton {
        let btn = addButton(title, backgroundColor: backgroundColor, textColor: textColor, showTimeout: showTimeout)
        btn.actionType = EAActionType.closure
        btn.action = action
        btn.addTarget(self, action:#selector(EAAlertView.buttonTapped(_:)), for:.touchUpInside)
        btn.addTarget(self, action:#selector(EAAlertView.buttonTapDown(_:)), for:[.touchDown, .touchDragEnter])
        btn.addTarget(self, action:#selector(EAAlertView.buttonRelease(_:)), for:[.touchUpInside, .touchUpOutside, .touchCancel, .touchDragOutside] )
        btn.setBackgroundImage(backgroundImage, for: .normal)
        return btn
    }
    
    @discardableResult
    open func addButton(backgroundImage:UIImage? = nil,_ title:String, backgroundColor:UIColor? = nil, textColor:UIColor? = nil, showTimeout:EAButton.ShowTimeoutConfiguration? = nil, target:AnyObject, selector:Selector)->EAButton {
        let btn = addButton(title, backgroundColor: backgroundColor, textColor: textColor, showTimeout: showTimeout)
        btn.actionType = EAActionType.selector
        btn.target = target
        btn.selector = selector
        btn.addTarget(self, action:#selector(EAAlertView.buttonTapped(_:)), for:.touchUpInside)
        btn.addTarget(self, action:#selector(EAAlertView.buttonTapDown(_:)), for:[.touchDown, .touchDragEnter])
        btn.addTarget(self, action:#selector(EAAlertView.buttonRelease(_:)), for:[.touchUpInside, .touchUpOutside, .touchCancel, .touchDragOutside] )
        btn.setBackgroundImage(backgroundImage, for: .normal)
        return btn
    }
    
    @discardableResult
    fileprivate func addButton(_ title:String, backgroundColor:UIColor? = nil, textColor:UIColor? = nil, showTimeout:EAButton.ShowTimeoutConfiguration? = nil)->EAButton {
        // Update view height
        appearance.setkWindowHeight(appearance.kWindowHeight + appearance.kButtonHeight)
        
        // Add button
        let btn = EAButton()
        btn.layer.masksToBounds = true
        btn.setTitle(title, for: UIControl.State())
        btn.titleLabel?.font = appearance.kButtonFont
        btn.customBackgroundColor = backgroundColor
        btn.customTextColor = textColor
        btn.initialTitle = title
        btn.showTimeout = showTimeout
        contentView.addSubview(btn)
        buttons.append(btn)
        
        return btn
    }
    
    @objc func buttonTapped(_ btn:EAButton) {
        if btn.actionType == EAActionType.closure {
            btn.action()
        } else if btn.actionType == EAActionType.selector {
            let ctrl = UIControl()
            ctrl.sendAction(btn.selector, to:btn.target, for:nil)
        } else {
            print("Unknow action type for button")
        }
        
        if(self.view.alpha != 0.0 && appearance.shouldAutoDismiss){ hideView() }
    }
    
    
    @objc func buttonTapDown(_ btn:EAButton) {
        var hue : CGFloat = 0
        var saturation : CGFloat = 0
        var brightness : CGFloat = 0
        var alpha : CGFloat = 0
        let pressBrightnessFactor = 0.85
        btn.backgroundColor?.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        brightness = brightness * CGFloat(pressBrightnessFactor)
        btn.backgroundColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    @objc func buttonRelease(_ btn:EAButton) {
        btn.backgroundColor = btn.customBackgroundColor ?? viewColor
    }
    
    var tmpContentViewFrameOrigin: CGPoint?
    var tmpCircleViewFrameOrigin: CGPoint?
    var keyboardHasBeenShown:Bool = false
    
    @objc func keyboardWillShow(_ notification: Notification) {
        keyboardHasBeenShown = true
        
        guard let userInfo = (notification as NSNotification).userInfo else {return}
        guard let endKeyBoardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.minY else {return}
        
        if tmpContentViewFrameOrigin == nil {
            tmpContentViewFrameOrigin = self.contentView.frame.origin
        }
        
        if tmpCircleViewFrameOrigin == nil {
            tmpCircleViewFrameOrigin = self.circleBG.frame.origin
        }
        
        var newContentViewFrameY = self.contentView.frame.maxY - endKeyBoardFrame
        if newContentViewFrameY < 0 {
            newContentViewFrameY = 0
        }
        
        let newBallViewFrameY = self.circleBG.frame.origin.y - newContentViewFrameY
        self.contentView.frame.origin.y -= newContentViewFrameY
        self.circleBG.frame.origin.y = newBallViewFrameY
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if(keyboardHasBeenShown){//This could happen on the simulator (keyboard will be hidden)
            if(self.tmpContentViewFrameOrigin != nil){
                self.contentView.frame.origin.y = self.tmpContentViewFrameOrigin!.y
                self.tmpContentViewFrameOrigin = nil
            }
            if(self.tmpCircleViewFrameOrigin != nil){
                self.circleBG.frame.origin.y = self.tmpCircleViewFrameOrigin!.y
                self.tmpCircleViewFrameOrigin = nil
            }
            
            keyboardHasBeenShown = false
        }
    }
    
    //Dismiss keyboard when tapped outside textfield & close EAAlertView when hideWhenBackgroundViewIsTapped
    @objc func tapped(_ gestureRecognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
        if let tappedView = gestureRecognizer.view , tappedView.hitTest(gestureRecognizer.location(in: tappedView), with: nil) == baseView && appearance.hideWhenBackgroundViewIsTapped {
            
            hideView()
        }
    }
    
    // showCustom(view, title, subTitle, UIColor, UIImage)
    @discardableResult
    open func showCustom(_ title: String, subTitle: String? = nil, color: UIColor, closeButtonTitle:String?=nil, timeout:EATimeoutConfiguration?=nil, colorTextButton: UInt=0xFFFFFF, circleIconImage: UIImage? = nil, backgorundCircleImage: UIImage? = nil, circleButtonTitle: String? = "", animationStyle: EAAnimationStyle = .topToBottom) -> EAAlertViewResponder {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        var colorAsUInt32 : UInt32 = 0
        colorAsUInt32 += UInt32(red * 255.0) << 16
        colorAsUInt32 += UInt32(green * 255.0) << 8
        colorAsUInt32 += UInt32(blue * 255.0)
        
        let colorAsUInt = UInt(colorAsUInt32)
        
        return showTitle(title, subTitle: subTitle, timeout: timeout, completeText:closeButtonTitle, style: .success, colorStyle: colorAsUInt, colorTextButton: colorTextButton, circleIconImage: circleIconImage, animationStyle: animationStyle)
    }
    
    // show(view, title, subTitle)
    @discardableResult
    open func show(_ title: String, subTitle: String? = nil, closeButtonTitle:String?=nil, timeout:EATimeoutConfiguration?=nil, colorStyle: UInt=EAAlertViewStyle.success.defaultColorInt, colorTextButton: UInt=0xFFFFFF, circleIconImage: UIImage? = nil, backgorundCircleImage: UIImage? = nil, circleButtonTitle: String? = "", animationStyle: EAAnimationStyle = .topToBottom) -> EAAlertViewResponder {
        return showTitle(title, subTitle: subTitle, timeout: timeout, completeText:closeButtonTitle, style: .success, colorStyle: colorStyle, colorTextButton: colorTextButton, circleIconImage: circleIconImage, backgorundCircleImage: backgorundCircleImage, circleButtonTitle: circleButtonTitle, animationStyle: animationStyle)
    }
    
    // showError(view, title, subTitle)
    @discardableResult
    open func showError(_ title: String, subTitle: String? = nil, closeButtonTitle:String?=nil, timeout:EATimeoutConfiguration?=nil, colorStyle: UInt=EAAlertViewStyle.error.defaultColorInt, colorTextButton: UInt=0xFFFFFF, circleIconImage: UIImage? = nil, backgorundCircleImage: UIImage? = nil, circleButtonTitle: String? = "", animationStyle: EAAnimationStyle = .topToBottom) -> EAAlertViewResponder {
        return showTitle(title, subTitle: subTitle, timeout: timeout, completeText:closeButtonTitle, style: .error, colorStyle: colorStyle, colorTextButton: colorTextButton, circleIconImage: circleIconImage, animationStyle: animationStyle)
    }
    
    // showNotice(view, title, subTitle)
    @discardableResult
    open func showNotice(_ title: String, subTitle: String? = nil, closeButtonTitle:String?=nil, timeout:EATimeoutConfiguration?=nil, colorStyle: UInt=EAAlertViewStyle.notice.defaultColorInt, colorTextButton: UInt=0xFFFFFF, circleIconImage: UIImage? = nil, backgorundCircleImage: UIImage? = nil, circleButtonTitle: String? = "", animationStyle: EAAnimationStyle = .topToBottom) -> EAAlertViewResponder {
        return showTitle(title, subTitle: subTitle, timeout: timeout, completeText:closeButtonTitle, style: .notice, colorStyle: colorStyle, colorTextButton: colorTextButton, circleIconImage: circleIconImage, animationStyle: animationStyle)
    }
    
    // showWarning(view, title, subTitle)
    @discardableResult
    open func showWarning(_ title: String, subTitle: String? = nil, closeButtonTitle:String?=nil, timeout:EATimeoutConfiguration?=nil, colorStyle: UInt=EAAlertViewStyle.warning.defaultColorInt, colorTextButton: UInt=0x000000, circleIconImage: UIImage? = nil, backgorundCircleImage: UIImage? = nil, circleButtonTitle: String? = "", animationStyle: EAAnimationStyle = .topToBottom) -> EAAlertViewResponder {
        return showTitle(title, subTitle: subTitle, timeout: timeout, completeText:closeButtonTitle, style: .warning, colorStyle: colorStyle, colorTextButton: colorTextButton, circleIconImage: circleIconImage, animationStyle: animationStyle)
    }
    
    // showInfo(view, title, subTitle)
    @discardableResult
    open func showInfo(_ title: String, subTitle: String? = nil, closeButtonTitle:String?=nil, timeout:EATimeoutConfiguration?=nil, colorStyle: UInt=EAAlertViewStyle.info.defaultColorInt, colorTextButton: UInt=0xFFFFFF, circleIconImage: UIImage? = nil, backgorundCircleImage: UIImage? = nil, circleButtonTitle: String? = "", animationStyle: EAAnimationStyle = .topToBottom) -> EAAlertViewResponder {
        return showTitle(title, subTitle: subTitle, timeout: timeout, completeText:closeButtonTitle, style: .info, colorStyle: colorStyle, colorTextButton: colorTextButton, circleIconImage: circleIconImage, animationStyle: animationStyle)
    }
    
    // showWait(view, title, subTitle)
    @discardableResult
    open func showWait(_ title: String, subTitle: String? = nil, closeButtonTitle:String?=nil, timeout:EATimeoutConfiguration?=nil, colorStyle: UInt?=EAAlertViewStyle.wait.defaultColorInt, colorTextButton: UInt=0xFFFFFF, circleIconImage: UIImage? = nil, backgorundCircleImage: UIImage? = nil, circleButtonTitle: String? = "", animationStyle: EAAnimationStyle = .topToBottom) -> EAAlertViewResponder {
        return showTitle(title, subTitle: subTitle, timeout: timeout, completeText:closeButtonTitle, style: .wait, colorStyle: colorStyle, colorTextButton: colorTextButton, circleIconImage: circleIconImage, animationStyle: animationStyle)
    }
    
    @discardableResult
    open func showEdit(_ title: String, subTitle: String? = nil, closeButtonTitle:String?=nil, timeout:EATimeoutConfiguration?=nil, colorStyle: UInt=EAAlertViewStyle.edit.defaultColorInt, colorTextButton: UInt=0xFFFFFF, circleIconImage: UIImage? = nil, backgorundCircleImage: UIImage? = nil, circleButtonTitle: String? = "", animationStyle: EAAnimationStyle = .topToBottom) -> EAAlertViewResponder {
        return showTitle(title, subTitle: subTitle, timeout: timeout, completeText:closeButtonTitle, style: .edit, colorStyle: colorStyle, colorTextButton: colorTextButton, circleIconImage: circleIconImage, animationStyle: animationStyle)
    }
    
    // showTitle(view, title, subTitle, style)
    @discardableResult
    open func showTitle(_ title: String, subTitle: String? = nil, style: EAAlertViewStyle, closeButtonTitle:String?=nil, timeout:EATimeoutConfiguration?=nil, colorStyle: UInt?=0x000000, colorTextButton: UInt=0xFFFFFF, circleIconImage: UIImage? = nil, backgorundCircleImage: UIImage? = nil, circleButtonTitle: String? = "", animationStyle: EAAnimationStyle = .topToBottom) -> EAAlertViewResponder {
        
        return showTitle(title, subTitle: subTitle, timeout:timeout, completeText:closeButtonTitle, style: style, colorStyle: colorStyle, colorTextButton: colorTextButton, circleIconImage: circleIconImage, animationStyle: animationStyle)
    }
    
    // showTitle(view, title, subTitle, timeout, style)
    @discardableResult
    open func showTitle(_ title: String, subTitle: String? = nil, timeout: EATimeoutConfiguration?, completeText: String?, style: EAAlertViewStyle, colorStyle: UInt?=0x000000, colorTextButton: UInt?=0xFFFFFF, circleIconImage: UIImage? = nil, backgorundCircleImage: UIImage? = nil, circleButtonTitle: String? = "", animationStyle: EAAnimationStyle = .topToBottom) -> EAAlertViewResponder {
        selfReference = self
        view.alpha = 0
        view.tag = uniqueTag
        view.accessibilityIdentifier = uniqueAccessibilityIdentifier
        let rv = UIApplication.shared.keyWindow! as UIWindow
        rv.addSubview(view)
        view.frame = rv.bounds
        baseView.frame = rv.bounds
        
        // Title
        if !title.isEmpty {
            self.labelTitle.text = title
            let actualHeight = title.heightWithConstrainedWidth(width: subViewsWidth, font: self.labelTitle.font)
            self.labelTitle.frame = CGRect(x:appearance.margin.horizontal, y:appearance.margin.titleTop, width: subViewsWidth, height:actualHeight)
        }
        
        // Subtitle
        if let subTitle = subTitle,
            !subTitle.isEmpty {
            viewText.text = subTitle
            // Adjust text view size, if necessary
            let str = subTitle as NSString
            let attr = [NSAttributedString.Key.font:viewText.font ?? UIFont()]
            let sz = CGSize(width: subViewsWidth, height:90)
            let r = str.boundingRect(with: sz, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes:attr, context:nil)
            let ht = ceil(r.size.height)
            if ht < appearance.kTextHeight {
                appearance.kWindowHeight -= (appearance.kTextHeight - ht)
                appearance.setkTextHeight(ht)
            }
        }
        
        // Done button
        if appearance.showCloseButton {
            _ = addButton(completeText ?? "Done", target:self, selector:#selector(EAAlertView.hideView))
        }
        
        //hidden/show circular view based on the ui option
        circleView.isHidden = !appearance.showCircularIcon
        circleBG.isHidden = !appearance.showCircularIcon
        
        // Alert view colour and images
        circleView.backgroundColor = viewColor
        
        // circleIconView = UIButton() //UIImageView(image: circleIconImage!)
        let x = (appearance.kCircleHeight - appearance.kCircleIconHeight) / 2
        
        circleButton = UIButton(frame: CGRect(x:-3, y:-4, width:appearance.kWindowWidth, height:kCircleHeightBackground))
        circleButton.setImage(circleIconImage, for: .normal)
        circleButton.setBackgroundImage(backgorundCircleImage, for: .normal)
        circleButton.setTitle(circleButtonTitle, for: .normal)
        circleButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -14, bottom: 0, right: 0)
        
        circleView.addSubview(circleButton)
        //circleView.addSubview(circleIconView)
        circleIconView.frame = CGRect( x: x, y: x, width: appearance.kCircleIconHeight, height: appearance.kCircleIconHeight)
        circleIconView.layer.masksToBounds = true
        
        for txt in inputs {
            txt.layer.borderColor = #colorLiteral(red: 0.8265416605, green: 0.8265416605, blue: 0.8265416605, alpha: 1)
        }
        
        for txt in input {
            txt.layer.borderColor = #colorLiteral(red: 0.8265416605, green: 0.8265416605, blue: 0.8265416605, alpha: 1)
        }
        
        for btn in buttons {
            //            if let customBackgroundColor = btn.customBackgroundColor {
            //                // Custom BackgroundColor set
            //                btn.backgroundColor = customBackgroundColor
            //            } else {
            //                // Use default BackgroundColor derived from AlertStyle
            //                btn.backgroundColor = viewColor
            //            }
            
            if let customTextColor = btn.customTextColor {
                // Custom TextColor set
                btn.setTitleColor(customTextColor, for:UIControl.State())
            } else {
                // Use default BackgroundColor derived from AlertStyle
                btn.setTitleColor(UIColorFromRGB(colorTextButton ?? 0xFFFFFF), for:UIControl.State())
            }
            
            btn.gradientColors = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]
        }
        
        // Adding timeout
        if let timeout = timeout {
            self.timeout = timeout
            timeoutTimer?.invalidate()
            timeoutTimer = Timer.scheduledTimer(timeInterval: timeout.value, target: self, selector: #selector(EAAlertView.hideViewTimeout), userInfo: nil, repeats: false)
            showTimeoutTimer?.invalidate()
            showTimeoutTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(EAAlertView.updateShowTimeout), userInfo: nil, repeats: true)
        }
        
        // Animate in the alert view
        self.showAnimation(animationStyle)
        
        // Chainable objects
        return EAAlertViewResponder(alertview: self)
    }
    
    // Show animation in the alert view
    fileprivate func showAnimation(_ animationStyle: EAAnimationStyle = .topToBottom, animationStartOffset: CGFloat = -400.0, boundingAnimationOffset: CGFloat = 15.0, animationDuration: TimeInterval = 0.2) {
        
        let rv = UIApplication.shared.keyWindow! as UIWindow
        var animationStartOrigin = self.baseView.frame.origin
        var animationCenter : CGPoint = rv.center
        
        switch animationStyle {
            
        case .noAnimation:
            self.view.alpha = 1.0
            return;
            
        case .topToBottom:
            animationStartOrigin = CGPoint(x: animationStartOrigin.x, y: self.baseView.frame.origin.y + animationStartOffset)
            animationCenter = CGPoint(x: animationCenter.x, y: animationCenter.y + boundingAnimationOffset)
            
        case .bottomToTop:
            animationStartOrigin = CGPoint(x: animationStartOrigin.x, y: self.baseView.frame.origin.y - animationStartOffset)
            animationCenter = CGPoint(x: animationCenter.x, y: animationCenter.y - boundingAnimationOffset)
            
        case .leftToRight:
            animationStartOrigin = CGPoint(x: self.baseView.frame.origin.x + animationStartOffset, y: animationStartOrigin.y)
            animationCenter = CGPoint(x: animationCenter.x + boundingAnimationOffset, y: animationCenter.y)
            
        case .rightToLeft:
            animationStartOrigin = CGPoint(x: self.baseView.frame.origin.x - animationStartOffset, y: animationStartOrigin.y)
            animationCenter = CGPoint(x: animationCenter.x - boundingAnimationOffset, y: animationCenter.y)
        }
        
        self.baseView.frame.origin = animationStartOrigin
        
        if self.appearance.dynamicAnimatorActive {
            UIView.animate(withDuration: animationDuration, animations: {
                self.view.alpha = 1.0
            })
            self.animate(item: self.baseView, center: rv.center)
        } else {
            UIView.animate(withDuration: animationDuration, animations: {
                self.view.alpha = 1.0
                self.baseView.center = animationCenter
            }, completion: { finished in
                UIView.animate(withDuration: animationDuration, animations: {
                    self.view.alpha = 1.0
                    self.baseView.center = rv.center
                })
            })
        }
    }
    
    // DynamicAnimator function
    var animator : UIDynamicAnimator?
    var snapBehavior : UISnapBehavior?
    
    fileprivate func animate(item : UIView , center: CGPoint) {
        
        if let snapBehavior = self.snapBehavior {
            self.animator?.removeBehavior(snapBehavior)
        }
        
        self.animator = UIDynamicAnimator.init(referenceView: self.view)
        let tempSnapBehavior  =  UISnapBehavior.init(item: item, snapTo: center)
        self.animator?.addBehavior(tempSnapBehavior)
        self.snapBehavior? = tempSnapBehavior
    }
    
    //
    @objc open func updateShowTimeout() {
        
        guard let timeout = self.timeout else {
            return
        }
        
        self.timeout?.value = timeout.value.advanced(by: -1)
        
        for btn in buttons {
            guard let showTimeout = btn.showTimeout else {
                continue
            }
            
            let timeoutStr: String = showTimeout.prefix + String(Int(timeout.value)) + showTimeout.suffix
            let txt = String(btn.initialTitle) + " " + timeoutStr
            btn.setTitle(txt, for: UIControl.State())
            
        }
        
    }
    
    // Close EAAlertView
    @objc open func hideView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 0
        }, completion: { finished in
            
            // Stop timeoutTimer so alertView does not attempt to hide itself and fire it's dimiss block a second time when close button is tapped
            self.timeoutTimer?.invalidate()
            
            // Stop showTimeoutTimer
            self.showTimeoutTimer?.invalidate()
            
            if let dismissBlock = self.dismissBlock {
                // Call completion handler when the alert is dismissed
                dismissBlock()
            }
            
            // This is necessary for EAAlertView to be de-initialized, preventing a strong reference cycle with the viewcontroller calling EAAlertView.
            for button in self.buttons {
                button.action = nil
                button.target = nil
                button.selector = nil
            }
            
            self.view.removeFromSuperview()
            self.selfReference = nil
        })
    }
    
    @objc open func hideViewTimeout() {
        self.timeout?.action()
        self.hideView()
    }
    
    func checkCircleIconImage(_ circleIconImage: UIImage?, defaultImage: UIImage) -> UIImage {
        if let image = circleIconImage {
            return image
        } else {
            return defaultImage
        }
    }
    
    //Return true if a EAAlertView is already being shown, false otherwise
    open func isShowing() -> Bool {
        if let subviews = UIApplication.shared.keyWindow?.subviews {
            for view in subviews {
                if view.tag == uniqueTag && view.accessibilityIdentifier == uniqueAccessibilityIdentifier {
                    return true
                }
            }
        }
        return false
    }
}

extension EAAlertView {
    var subViewsWidth: CGFloat {
        return appearance.kWindowWidth - 2 * appearance.margin.horizontal
    }
}

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}
