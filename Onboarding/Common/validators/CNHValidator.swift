//
//  CNHValidator.swift
//  FadeExample
//
//  Created by Ryan Fitzgerald on 9/22/14.
//  Copyright (c) 2014 rebase. All rights reserved.
//

import Foundation

protocol Validator {
    func validate() -> (Bool, NSError?)
}

class EmailValidator : Validator {
    
    var input: String?
    
    convenience init(input: String) {
        self.init()
        self.input = input
    }
    
    func validate() -> (Bool, NSError?) {
        if let email : String = input {
            
            if(email.isEmpty) {
                return (true, nil)
            }
            
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
            let emailTest : NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)!
            
            if emailTest.evaluateWithObject(email) {
                return (true, nil)
            } else {
                var err : NSError = NSError(domain: "com.clutchretail.cinch", code: 1, userInfo: [NSLocalizedDescriptionKey:"Email is not valid"])
                return (false, err)
            }
        } else {
            return (true, nil)
        }
        
    }
}

class PasswordValidator : Validator {
    
    var input: String?
    
    convenience init(input: String) {
        self.init()
        self.input = input
    }
    
    func validate() -> (Bool, NSError?) {
        if let password : String = input {
            
            if(password.isEmpty) {
                return (true, nil)
            } else if (countElements(password) < 5) {
                var err : NSError = NSError(domain: "com.clutchretail.cinch", code: 1, userInfo: [NSLocalizedDescriptionKey:"Password must be at least 5 characters long"])
                return (false, err)
            } else {
                return (true, nil)
            }
        } else {
            return (true, nil)
        }
        
        
    }
}

class PhoneNumberValidator : Validator {
    
    var input: String?
    
    convenience init(input: String) {
        self.init()
        self.input = input
    }
    
    func validate() -> (Bool, NSError?) {
        if let phoneNumber : String = input {
            
            if(phoneNumber.isEmpty) {
                return (true, nil)
            } else if (countElements(phoneNumber) < 10) {
                var err : NSError = NSError(domain: "com.clutchretail.cinch", code: 1, userInfo: [NSLocalizedDescriptionKey:"Phone number is not valid"])
                return (false, err)
            } else {
                return (true, nil)
            }
        } else {
            return (true, nil)
        }
        
        
    }
}