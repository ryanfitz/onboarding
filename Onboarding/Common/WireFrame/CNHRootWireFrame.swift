//
//  CNHRootWireFrame.swift
//  Cinch
//
//  Created by Ryan Fitzgerald on 1/19/15.
//  Copyright (c) 2015 rebase. All rights reserved.
//

import Foundation

class CNHRootWireFrame {
    class func showRootViewController(viewController : UIViewController, inWindow window:UIWindow) {
        UIView.transitionWithView(window, duration: 0.25, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            window.rootViewController = viewController
        }, completion: { (fininshed: Bool) -> () in
        })
    }
    
    class func presentTabBarControlller(fromViewController : UIViewController) {
        let vc = CNHTabBarController()
        vc.modalPresentationStyle = .OverCurrentContext
        vc.modalTransitionStyle = .CrossDissolve
        
        fromViewController.presentViewController(vc, animated: true, completion: nil)
    }
}