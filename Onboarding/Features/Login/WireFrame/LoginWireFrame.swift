//
//  IntroWireFrame.swift
//  Cinch
//
//  Created by Ryan Fitzgerald on 1/19/15.
//  Copyright (c) 2015 rebase. All rights reserved.
//

import Foundation

class LoginWireFrame {
    class func presentSignupInterfaceFrom(fromViewController : UIViewController) {
        var vc : LoginViewController = LoginViewController()
        
        var nav : UINavigationController = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .OverCurrentContext
        nav.modalTransitionStyle = .CoverVertical
        
        fromViewController.presentViewController(nav, animated: true, completion: nil)
    }
}