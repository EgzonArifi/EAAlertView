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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //alertTextInput()
        //alertPickerView()
        //alertDatePickerView()
        alertTermsView()
    }
    
    func alertTermsView() {
        
        let appearance = EAAlertView.EAAppearance(kTextViewdHeight: self.view.frame.height*0.6, kButtonHeight: 60, showCloseButton: false, shouldAutoDismiss: false)
        let alert = EAAlertView(appearance: appearance)
        
        let textView = alert.addTextView()
        textView.text = "UITextView displays a region that can contain multiple lines of editable text. When a user taps a text view, a keyboard appears; when a user taps Return in the keyboard, the keyboard disappears and the text view can handle the input in an application-specific way. You can specify attributes, such as font, color, and alignment, that apply to all text in a text view. UITextView displays a region that can contain multiple lines of editable text. When a user taps a text view, a keyboard appears; when a user taps Return in the keyboard, the keyboard disappears and the text view can handle the input in an application-specific way. You can specify attributes, such as font, color, and alignment, that apply to all text in a text view.UITextView displays a region that can contain multiple lines of editable text. When a user taps a text view, a keyboard appears; when a user taps Return in the keyboard, the keyboard disappears and the text view can handle the input in an application-specific way. You can specify attributes, such as font, color, and alignment, that apply to all text in a text view. UITextView displays a region that can contain multiple lines of editable text. When a user taps a text view, a keyboard appears; when a user taps Return in the keyboard, the keyboard disappears and the text view can handle the input in an application-specific way. You can specify attributes, such as font, color, and alignment, that apply to all text in a text view."
        
        _ = alert.addButton(backgroundImage: #imageLiteral(resourceName: "gradient_btn"),"Akzeptieren") {
            alert.dismiss(animated: true, completion: .none)
        }
        _ = alert.showSuccess("AGB's", subTitle: "")
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
        _ = alert.showSuccess("Birthdate", subTitle: "Gib den Vierstelligen Code ein")
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
        _ = alert.showSuccess("Number of kids", subTitle: "Gib den Vierstelligen Code ein")
    }
    
    func alertTextInput() {
        
        let appearance = EAAlertView.EAAppearance(
            kTextFieldHeight: 60,
            kButtonHeight: 60,
            showCloseButton: false,
            shouldAutoDismiss: false
        )
        
        let alert = EAAlertView(appearance: appearance)
        
        let txtCode = alert.addTextField("Eingeben")
        txtCode.keyboardType = .phonePad
        txtCode.accessibilityIdentifier = "alertSMSCode"
        
        let btn = alert.addButton(backgroundImage: #imageLiteral(resourceName: "gradient_btn"),"Login") {
            if let code = txtCode.text {
                print(code)
                self.alerLoginButton.animate(animation: .collapse)
            }
        }
        self.alerLoginButton = btn
        
        _ = alert.addButton("Kein Code erhalten?", backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), textColor:#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)) {
            
        }
        _ = alert.showSuccess("SMS Code", subTitle: "Gib den Vierstelligen Code ein")
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
