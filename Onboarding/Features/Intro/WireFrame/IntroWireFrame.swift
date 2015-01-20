//
//  IntroWireFrame.swift
//  Cinch
//
//  Created by Ryan Fitzgerald on 1/19/15.
//  Copyright (c) 2015 rebase. All rights reserved.
//

import Foundation

class IntroWireFrame {
    class func presentIntroInterfaceFromWindow(window : UIWindow) {
        let vc : UIViewController = IntroViewController()
        window.rootViewController = vc
    }
    
    class func presentMainAppInterfaceFromWindow(window : UIWindow) {
        let vc : UIViewController = CNHTabBarController()
        window.rootViewController = vc
    }
}