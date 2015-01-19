//
//  VerifyPhoneViewController.swift
//  Cinch
//
//  Created by Ryan Fitzgerald on 9/25/14.
//  Copyright (c) 2014 rebase. All rights reserved.
//

import UIKit

class VerifyPhoneViewController: UIViewController, UITextFieldDelegate {
    let blurEffect : UIBlurEffect = UIBlurEffect(style: .Dark)
    let backgroundView : UIVisualEffectView
    
    let foregroundContentView : UIView = UIView()
    let foregroundContentScrollView : UIScrollView = UIScrollView()
    
    let countryCodeTextField : CNHFloatLabeledTextFieldView = CNHFloatLabeledTextFieldView(title: "Country Code")
    let phoneNumberTextField : CNHFloatLabeledTextFieldView = CNHFloatLabeledTextFieldView(title: "Mobile Number")
    let authCodeTextField : CNHFloatLabeledTextFieldView = CNHFloatLabeledTextFieldView(title: "Cinch Code")

    let textFields : [CNHFloatLabeledTextFieldView]
    
    let verifyButton : UIButton = UIButton.buttonWithType(.Custom) as UIButton
    let verifyLabel : UILabel = UILabel()
    let privacyLabel : UILabel = UILabel()
    
    var autoCodeHeightConstraint : MASConstraint?
    
    override init() {
        backgroundView = UIVisualEffectView(effect: blurEffect)
        textFields = [countryCodeTextField, phoneNumberTextField, authCodeTextField]
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Verify Phone #"
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.translucent = true
            navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
            navigationBar.shadowImage = UIImage()
            //            navigationBar.shadowImage = self.imageWithColor(UIColor.darkGrayColor())
            navigationBar.tintColor = UIColor.whiteColor()
            navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        }
        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Stop, target: self, action: Selector("tappedClose:"))
        
        verifyButton.backgroundColor = UIColor(red: 19/255, green: 173/255, blue: 163/255, alpha: 1)
        verifyButton.setTitle("Verify", forState: .Normal)
        verifyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        verifyButton.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        verifyButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        verifyButton.layer.cornerRadius = 4
        verifyButton.contentEdgeInsets = UIEdgeInsetsMake(7, 8 , 7, 8)
        verifyButton.sizeToFit()
        verifyButton.addTarget(self, action: Selector("didTapVerify"), forControlEvents: UIControlEvents.TouchUpInside)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: verifyButton)
        
        view.addSubview(backgroundView)
        backgroundView.contentView.addSubview(foregroundContentScrollView)
        
        foregroundContentScrollView.addSubview(foregroundContentView)
        
        countryCodeTextField.labeledTextField.text = "US - United States"
        phoneNumberTextField.labeledTextField.keyboardType = .NumberPad
        authCodeTextField.labeledTextField.keyboardType = .NumberPad
        authCodeTextField.alpha = 0
        
        for view in textFields {
            view.labeledTextField.delegate = self
            foregroundContentView.addSubview(view)
        }
        
        verifyLabel.numberOfLines = 0
        verifyLabel.lineBreakMode = .ByWordWrapping
        verifyLabel.font = UIFont.systemFontOfSize(12)
        verifyLabel.textAlignment = .Center
        verifyLabel.textColor = UIColor.whiteColor()
        verifyLabel.text = "Please verify your phone number so we know\nyou're a real person!"
        foregroundContentView.addSubview(verifyLabel)
        
        let privacyText : String = "Privacy Policy"
        let privacyStatementText : NSString = "We will not share your phone number to other users.\nRead our \(privacyText) to learn more."
        
        var attribs : [NSObject : AnyObject] = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName : UIFont.systemFontOfSize(11)]
        var attributedText : NSMutableAttributedString = NSMutableAttributedString(string: privacyStatementText, attributes: attribs)
        var highlightAttribs : [NSObject : AnyObject] = [NSForegroundColorAttributeName : UIColor(red: 19/255, green: 173/255, blue: 163/255, alpha: 1)]
        
        attributedText.setAttributes(highlightAttribs, range: privacyStatementText.rangeOfString(privacyText, options: .LiteralSearch))
        
        privacyLabel.attributedText = attributedText
        privacyLabel.numberOfLines = 0
        privacyLabel.lineBreakMode = .ByWordWrapping
        privacyLabel.font = UIFont.systemFontOfSize(11)
        foregroundContentView.addSubview(privacyLabel)
        
        self.layoutSubviews()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardDidShow:"), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillBeHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        phoneNumberTextField.becomeFirstResponder()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func layoutSubviews() {
        var superview : UIView = self.view
        
        backgroundView.mas_makeConstraints { (make) -> Void in
            make.edges.equalTo()(superview)
            return ()
        }
        
        foregroundContentScrollView.mas_makeConstraints { (make) -> Void in
            var topLayoutGuide : AnyObject = self.topLayoutGuide;
            
            if let topGuide = topLayoutGuide as? UIView {
                make.top.equalTo()(topGuide.mas_bottom);
                make.left.equalTo()(self.backgroundView)
                make.right.equalTo()(self.backgroundView)
                make.bottom.equalTo()(self.backgroundView)
            }
            
            return ()
        }
        
        foregroundContentView.mas_makeConstraints { (make) -> Void in
            var edge : CGFloat = 15
            var padding : UIEdgeInsets = UIEdgeInsetsMake(0, edge, 0, edge);
            make.edges.equalTo()(self.foregroundContentScrollView).with().insets()(padding)
            make.width.equalTo()(self.foregroundContentScrollView.mas_width).offset()(-padding.right * 2)
            return ()
        }
        
        self.generateTextFieldConstraints()
    }
    
    func generateTextFieldConstraints() {
        
        verifyLabel.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(self.foregroundContentView.mas_top)
            make.left.equalTo()(0)
            make.width.equalTo()(self.foregroundContentView.mas_width)
            
            return ()
        }
        
        var lastView : UIView = verifyLabel
        
        for (index, view) in enumerate(textFields) {
            view.mas_makeConstraints { (make) -> Void in
                let offset : CGFloat = index == 0 ? 16 : 8
                make.top.equalTo()(lastView.mas_bottom).offset()(offset)
                make.left.equalTo()(0)
                make.width.equalTo()(self.foregroundContentView.mas_width)
                
                if(view == self.authCodeTextField) {
                    self.autoCodeHeightConstraint = make.height.equalTo()(0)
                } else {
                    make.height.greaterThanOrEqualTo()(44)
                }
                
                return ()
            }
            
            lastView = view
        }
        
        privacyLabel.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(lastView.mas_bottom).offset()(8)
            make.left.equalTo()(0)
            make.width.equalTo()(self.foregroundContentView.mas_width)
            
            return ()
        }
        
        foregroundContentView.mas_makeConstraints { (make) -> Void in
            make.bottom.equalTo()(self.privacyLabel.mas_bottom)
            return ()
        }
    }
    
    func updateTextFieldConstraints() {
        for view in [phoneNumberTextField] {
            var height : CGFloat = 44
            
            if(view.state == CNHTextFieldControlState.Error) {
                height = 58
            }
            
            view.mas_updateConstraints { (make) -> Void in
                make.height.equalTo()(height)
                return ()
            }
        }
        
//        UIView.animateWithDuration(0.25, animations: {
//            self.view.layoutIfNeeded()
//        })
    }
    
    func tappedClose (sender : AnyObject) {
        view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imageWithColor(color : UIColor) -> UIImage {
        var rect : CGRect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        var context : CGContextRef = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    func keyboardDidShow (notification : NSNotification ) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            foregroundContentScrollView.contentInset = contentInsets
            foregroundContentScrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    func keyboardWillBeHide (notification : NSNotification ) {
        var contentInsets : UIEdgeInsets = UIEdgeInsetsZero
        foregroundContentScrollView.contentInset = contentInsets
        foregroundContentScrollView.scrollIndicatorInsets = contentInsets
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return textField != countryCodeTextField.labeledTextField
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        for view in textFields {
            if(view.labeledTextField == textField) {
                view.state = .Selected
            } else if(view.state != .Error) {
                view.state = .Normal
            }
        }
        
        //        self.updateTextFieldConstraints()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if(textField == phoneNumberTextField.labeledTextField) {
            self.validatePhoneNumberField()
        }
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(Float(NSEC_PER_SEC) * 0)), dispatch_get_main_queue(), {
//            self.updateTextFieldConstraints()
//        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        for (index, view) in enumerate(textFields) {
            if (view.labeledTextField == textField && (textFields.count > index + 1)) {
                
                if let nextView = self.textFields[index + 1] as UIView? {
                    nextView.becomeFirstResponder()
                }
            }
        }
        
        return false
    }
    
    func validatePhoneNumberField () {
        var validator : Validator = PhoneNumberValidator(input: phoneNumberTextField.labeledTextField.text)
        let (valid, err) = validator.validate()
        if(!valid) {
            phoneNumberTextField.state = .Error
            phoneNumberTextField.errorMessageLabel.text = err?.localizedDescription
        } else {
            phoneNumberTextField.state = .Normal
            phoneNumberTextField.errorMessageLabel.text = ""
        }
    }
    
    func displayAuthCodeField () {
        if let constraint = self.autoCodeHeightConstraint? {
            constraint.uninstall()
            
            self.autoCodeHeightConstraint = nil
            
            self.authCodeTextField.mas_makeConstraints { (make) -> Void in
                make.height.greaterThanOrEqualTo()(44)
                return ()
            }
            
            UIView.animateWithDuration(0.25,
                delay : 0,
                options: .CurveEaseOut,
                animations: {
                    self.authCodeTextField.alpha = 1
                    self.view.layoutIfNeeded()
                }, completion: { (value: Bool) in
                    self.authCodeTextField.becomeFirstResponder()
                    return ()
            })
        }
    }
    
    // MARK: Actions
    func didTapVerify() {
        self.validatePhoneNumberField()
        self.updateTextFieldConstraints()
        
        if(phoneNumberTextField.state != .Error) {
            self.displayAuthCodeField()
        }
    }
}
