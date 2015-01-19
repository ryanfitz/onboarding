//
//  CNHFloatLabeledTextFieldView.swift
//  FadeExample
//
//  Created by Ryan Fitzgerald on 9/21/14.
//  Copyright (c) 2014 rebase. All rights reserved.
//

import UIKit

enum CNHTextFieldControlState {
    case Normal
    case Selected
    case Error
    case Disabled
}

class CNHFloatLabeledTextFieldView: UIView {
    let labeledTextField : JVFloatLabeledTextField = JVFloatLabeledTextField()
    let border : UIView = UIView()
    let errorMessageLabel : UILabel = UILabel()
    
    var state: CNHTextFieldControlState = .Normal {
        didSet {
            switch state {
            case .Selected:
                border.backgroundColor = UIColor(red: 19/255, green: 173/255, blue: 163/255, alpha: 1)
                self.updateBorderHeight(2)
                self.updateErrorMessageConstraint()
            case .Error:
                border.backgroundColor = UIColor(red: 228/255, green: 48/255, blue: 36/255, alpha: 1)
                self.updateBorderHeight(2)
                self.updateErrorMessageConstraint()
            default:
                border.backgroundColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 0.5)
                self.updateBorderHeight(1)
                self.updateErrorMessageConstraint()
            }
        }
    }
    
    init(title : String) {
        super.init()
//        self.backgroundColor = UIColor.redColor()
        labeledTextField.attributedPlaceholder = NSAttributedString(string: title, attributes: [
            NSForegroundColorAttributeName: UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1),
            NSFontAttributeName : UIFont.systemFontOfSize(16)]
        )
        
        labeledTextField.setPlaceholder(title, floatingTitle: title)
        labeledTextField.textColor = UIColor.whiteColor()
        labeledTextField.font = UIFont.systemFontOfSize(16)
        labeledTextField.floatingLabel.font = UIFont.boldSystemFontOfSize(11)
        labeledTextField.floatingLabelTextColor = UIColor(red: 114/255, green: 114/255, blue: 114/255, alpha: 1)
        labeledTextField.floatingLabelActiveTextColor = UIColor(red: 19/255, green: 173/255, blue: 163/255, alpha: 1)
        labeledTextField.clearButtonMode = .WhileEditing
        labeledTextField.keyboardAppearance = .Dark;
        labeledTextField.tintColor = UIColor(red: 19/255, green: 173/255, blue: 163/255, alpha: 1)
        labeledTextField.autocapitalizationType = .Words
        labeledTextField.returnKeyType = .Next
//        labeledTextField.placeholderYPadding = -30
//        labeledTextField.floatingLabelYPadding = -12
        
        border.backgroundColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 0.5)
        
        errorMessageLabel.textColor = UIColor(red: 228/255, green: 48/255, blue: 36/255, alpha: 1)
        errorMessageLabel.font = UIFont.boldSystemFontOfSize(11)
        
        self.addSubview(labeledTextField)
        self.addSubview(border)
        self.addSubview(errorMessageLabel)
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let superview : UIView = self
        
        labeledTextField.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(superview)
            make.left.equalTo()(superview)
            make.right.equalTo()(superview)
            make.width.equalTo()(superview)
            make.height.greaterThanOrEqualTo()(36)
            make.bottom.lessThanOrEqualTo()(self.border.mas_top)

            return ()
        }
        
        border.mas_makeConstraints { (make) -> Void in
            make.top.greaterThanOrEqualTo()(self.labeledTextField.mas_bottom).with().offset()(4)
            make.left.equalTo()(superview)
            make.right.equalTo()(superview)
            make.width.equalTo()(superview)
            make.height.lessThanOrEqualTo()(2)
            
            return ()
        }
        
        errorMessageLabel.mas_makeConstraints { (make) -> Void in
            make.top.greaterThanOrEqualTo()(self.border.mas_bottom).with().offset()(4)
            make.left.equalTo()(superview)
            make.right.equalTo()(superview)
            make.width.equalTo()(superview)
            make.height.lessThanOrEqualTo()(12)
            
            return ()
        }
    }
    
    func updateBorderHeight(height : Int ) {
        border.mas_updateConstraints { (make) -> Void in
            make.height.equalTo()(height)
            return ()
        }
        
        super.updateConstraints()
    }

    func updateErrorMessageConstraint() {
        errorMessageLabel.mas_updateConstraints { (make) -> Void in
            if(self.state == .Error) {
                make.height.equalTo()(12)
            } else {
                make.height.equalTo()(0)
            }
            return ()
        }
        
        super.updateConstraintsIfNeeded()
        
        UIView.animateWithDuration(0.25, animations: {
            self.errorMessageLabel.layoutIfNeeded()
        })

    }
    
    override func becomeFirstResponder() -> Bool {
        return labeledTextField.becomeFirstResponder()
    }
}
