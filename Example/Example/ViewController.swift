//
//  ViewController.swift
//  Example
//
//  Created by Egzon Arifi on 8/14/18.
//  Copyright © 2018 Overjump. All rights reserved.
//

import UIKit
import EAAlertView

class ViewController: UIViewController {

    var alerLoginButton: EAButton!
    @IBOutlet weak var numberOfChildren: UITextField!
    var resultTextField: UITextField!
    var numberOfChildrens = Array(0...12)
    var count = 1120
    var alert: EAAlertView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showActivateAlert()
        //alertTextInput()
        //alertPickerView()
        //alertDatePickerView()
        //alertTermsView()
    }
    
    func showActivateAlert() {
        
        let appearance = EAAlertView.EAAppearance(
            kTextFieldHeight: 60,
            kButtonHeight: 60,
            kTitleFont: UIFont.boldSystemFont(ofSize: 21),
            showCloseButton: false,
            showCircularIcon: true,
            shouldAutoDismiss: false
        )
        
        alert = EAAlertView(appearance: appearance)
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width*0.8, height: 210))
        let imageView = UIImageView(image: #imageLiteral(resourceName: "partnerLogo"))
        imageView.frame = CGRect(x: self.view.frame.width*0.4 - 47, y: 0, width: 100, height: 100)
        imageView.contentMode = .scaleAspectFit
        customView.addSubview(imageView)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 100, width: self.view.frame.width*0.8, height: 70))
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.text = "Gratis Punch & Glowstick von Zauberwald Lenzerheide"
        titleLabel.textAlignment = .center
        customView.addSubview(titleLabel)
        
        let partnerNameLabel = UILabel(frame: CGRect(x: 0, y: 160, width: self.view.frame.width*0.8, height: 40))
        partnerNameLabel.numberOfLines = 2
        partnerNameLabel.textAlignment = .center
        partnerNameLabel.text = "Zauberwald Lenzerheide"
        customView.addSubview(partnerNameLabel)

        alert.customSubview = customView
        
        let btn = alert.addButton(backgroundImage: #imageLiteral(resourceName: "gradient_btn"), "Für 60min aktivieren") {
            self.alert.hideView()
        }
        _ = alert.show("", subTitle: "", circleIconImage: #imageLiteral(resourceName: "coupon_image"), backgorundCircleImage: #imageLiteral(resourceName: "green_gradient"), circleButtonTitle: "Aktivieren nowiren")
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)

    }
    
    @objc func update() {
        if(count > 0) {
            count -= 1
            print(count)
            
            let date = NSDate()
            let calendar = Calendar.current
            
            let components = calendar.dateComponents([.second, .hour, .minute, .month, .year, .day], from: date as Date)
            
            let currentDate = calendar.date(from: components)
            
            let userCalendar = Calendar.current
            
            // here we set the due date. When the timer is supposed to finish
            let competitionDate = NSDateComponents()
            competitionDate.year = 2018
            competitionDate.month = 10
            competitionDate.day = 01
            competitionDate.hour = 17
            competitionDate.minute = 00
            competitionDate.second = 00
            let competitionDay = userCalendar.date(from: competitionDate as DateComponents)!
            
            //here we change the seconds to hours,minutes and days
            let CompetitionDayDifference = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate!, to: competitionDay)
            
            
            //finally, here we set the variable to our remaining time
            let daysLeft = CompetitionDayDifference.day
            let hoursLeft = CompetitionDayDifference.hour
            let minutesLeft = CompetitionDayDifference.minute
            let secondsLeft = CompetitionDayDifference.second
            print("day:", daysLeft ?? "N/A", "hour:", hoursLeft ?? "N/A", "minute:", minutesLeft ?? "N/A", "second:", secondsLeft ?? "N/A")
            
            //Set countdown label text
            alert.circleButton.setTitle("Coupon aktiv (\(hoursLeft ?? 00):\(minutesLeft ?? 00):\(secondsLeft ?? 00))", for: .normal)
            //alert.circleButton.setTitle("Coupon aktiv (\(count))", for: .normal)
        }
    }
    
    func alertTermsView() {
        
        let appearance = EAAlertView.EAAppearance(kTextViewdHeight: self.view.frame.height*0.6, kButtonHeight: 60, showCloseButton: false, shouldAutoDismiss: false)
        let alert = EAAlertView(appearance: appearance)
        
        let textView = alert.addTextView()
        textView.text = "UITextView displays a region that can contain multiple lines of editable text. When a user taps a text view, a keyboard appears; when a user taps Return in the keyboard, the keyboard disappears and the text view can handle the input in an application-specific way. You can specify attributes, such as font, color, and alignment, that apply to all text in a text view. UITextView displays a region that can contain multiple lines of editable text. When a user taps a text view, a keyboard appears; when a user taps Return in the keyboard, the keyboard disappears and the text view can handle the input in an application-specific way. You can specify attributes, such as font, color, and alignment, that apply to all text in a text view.UITextView displays a region that can contain multiple lines of editable text. When a user taps a text view, a keyboard appears; when a user taps Return in the keyboard, the keyboard disappears and the text view can handle the input in an application-specific way. You can specify attributes, such as font, color, and alignment, that apply to all text in a text view. UITextView displays a region that can contain multiple lines of editable text. When a user taps a text view, a keyboard appears; when a user taps Return in the keyboard, the keyboard disappears and the text view can handle the input in an application-specific way. You can specify attributes, such as font, color, and alignment, that apply to all text in a text view."
        
        _ = alert.addButton(backgroundImage: #imageLiteral(resourceName: "gradient_btn"),"Accept") {
            alert.dismiss(animated: true, completion: .none)
        }
        _ = alert.show("Terms", subTitle: "")
    }
    
    func alertDatePickerView() {
        
        let picker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.width*0.8, height: 200))
        picker.datePickerMode = UIDatePickerMode.date

        let appearance = EAAlertView.EAAppearance(kButtonHeight: 60, showCloseButton: false, shouldAutoDismiss: false)
        let alert = EAAlertView(appearance: appearance)
        alert.customSubview = picker
        
        _ = alert.addButton(backgroundImage: #imageLiteral(resourceName: "gradient_btn"),"Select") {
            alert.dismiss(animated: true, completion: .none)
        }
        _ = alert.show("Birthdate", subTitle: "Gib den Vierstelligen Code ein")
    }
    
    func alertPickerView() {
        
        let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width*0.8, height: 200))
        picker.delegate = self
        
        let appearance = EAAlertView.EAAppearance(kButtonHeight: 60, showCloseButton: false, shouldAutoDismiss: false)
        let alert = EAAlertView(appearance: appearance)
        alert.customSubview = picker
        
        _ = alert.addButton(backgroundImage: #imageLiteral(resourceName: "gradient_btn"),"Select") {
            alert.dismiss(animated: true, completion: .none)
        }
        _ = alert.show("Picker", subTitle: "Gib den Vierstelligen Code ein")
    }
    
    func alertTextInput() {
        
        let appearance = EAAlertView.EAAppearance(
            kTextFieldHeight: 60,
            kButtonHeight: 60,
            showCloseButton: false,
            shouldAutoDismiss: false
        )
        
        let alert = EAAlertView(appearance: appearance)
        
        let txtCode = alert.addTextField("type")
        txtCode.keyboardType = .phonePad
        txtCode.accessibilityIdentifier = "alertSMSCode"
        
        let btn = alert.addButton(backgroundImage: #imageLiteral(resourceName: "gradient_btn"),"Login") {
            if let code = txtCode.text {
                print(code)
                self.alerLoginButton.animate(animation: .collapse)
            }
        }
        self.alerLoginButton = btn
        
        _ = alert.addButton("No code received?", backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), textColor:#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)) {
            
        }
        _ = alert.show("SMS Code", subTitle: "Enter the four-digit code")
    }


}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfChildrens.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberOfChildrens[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.numberOfChildren.text = "\(numberOfChildrens[row])"
    }
}
