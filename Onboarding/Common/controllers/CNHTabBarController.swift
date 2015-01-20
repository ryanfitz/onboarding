//
//  CNHTabBarController.swift
//  Cinch
//
//  Created by Ryan Fitzgerald on 1/19/15.
//  Copyright (c) 2015 rebase. All rights reserved.
//

import Foundation

class CNHTabBarController : UITabBarController {
    let greenBackground = UIView()
    
    override func viewDidLoad() {
        let vc1 = UINavigationController(rootViewController: UIViewController())
        vc1.navigationBar.barStyle = .Default
        vc1.navigationBar.barTintColor = UIColor(red: 19/255.0, green: 173/255.0, blue: 163/255.0, alpha: 1)
        vc1.navigationBar.translucent = false
        
        let vc2 = UIViewController();
        let vc3 = UIViewController();
        let vc4 = UIViewController();
        let vc5 = UIViewController();
        
        var createPollImage : UIImage = UIImage(named:"createpoll-add")!.imageWithRenderingMode(.AlwaysOriginal)
        vc1.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "home-off"), tag: 1)
        vc2.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "explore-off"), tag: 2)
        vc3.tabBarItem = UITabBarItem(title: nil, image: createPollImage, tag: 3)
        vc4.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "nofitication"), tag: 4)
        vc5.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "profile"), tag: 5)
        
        let controllers : [UIViewController] = [vc1, vc2, vc3, vc4, vc5]
        for vc in controllers {
           vc.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
           vc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        }
        
        self.viewControllers = controllers
        
        self.tabBar.barTintColor = UIColor(red: 17/255, green: 19/255, blue: 22/255, alpha: 1)
        self.tabBar.tintColor = UIColor.whiteColor()
        self.tabBar.backgroundColor = UIColor.blackColor()
        self.tabBar.translucent = false

        greenBackground.layer.cornerRadius = 8.0
        greenBackground.backgroundColor = UIColor(red: 19/255.0, green: 173/255.0, blue: 163/255.0, alpha: 1)
        tabBar.insertSubview(greenBackground, atIndex: 0)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.redColor()], forState:.Selected)
    }
    
    override func viewWillLayoutSubviews() {
        let itemIndex : CGFloat = 2
        let w = CGRectGetWidth(tabBar.frame)
        let itemWidth : CGFloat = w / CGFloat(tabBar.items!.count)
        
        greenBackground.frame = CGRectMake((itemWidth * itemIndex) + 2, 3, itemWidth - 4, tabBar.frame.height - 6)
    }
    
    
}