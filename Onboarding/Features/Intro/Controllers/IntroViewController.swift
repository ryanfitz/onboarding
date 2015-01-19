//
//  ViewController.swift
//  FadeExample
//
//  Created by Ryan Fitzgerald on 9/18/14.
//  Copyright (c) 2014 rebase. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, SwipeViewDataSource, SwipeViewDelegate {

    let signupButton : UIButton = UIButton.buttonWithType(.Custom) as UIButton
    let loginButton : UIButton = UIButton.buttonWithType(.Custom) as UIButton
    let separator : UIView = UIView()
    let pageControl : FXPageControl = FXPageControl()
    
    let logo : UIImageView = UIImageView(image: UIImage(named: "cinchLogo"))
    let chatIcon : UIImageView = UIImageView(image: UIImage(named: "cinch-chat-icon"))

    let swipeView : SwipeView = SwipeView()
    let messages : [String] = [
        "She used Cinch to decide\non an outfit.",
        "He used Cinch to decide\non their favorite photo.",
        "They used Cinch to decide\nwhere to eat.",
        "Decide with Friends\n"
    ]
    
    var currentScrollOffset : CGFloat?
    
    let introImages : [UIImage] = [
        UIImage(named: "intro-bg-1")!,
        UIImage(named: "intro-bg-2")!,
        UIImage(named: "intro-bg-3")!,
        UIImage(named: "intro-bg-4")!
    ]
    
    let currentImageView = UIImageView()
    let nextImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        // current image view needs to be added over the next view
        currentImageView.image = introImages.first
        nextImageView.image = introImages[1]
        
        for imageView in [nextImageView, currentImageView] {
            imageView.contentMode = .ScaleAspectFill
            view.addSubview(imageView)
        }
        
        currentScrollOffset = 0
        
        chatIcon.alpha = 0
        chatIcon.transform = CGAffineTransformMakeScale(0, 0)
        
        view.addSubview(chatIcon)
        
        view.addSubview(logo)
        
        swipeView.pagingEnabled = true
        swipeView.delegate = self
        swipeView.dataSource = self
        
        view.addSubview(swipeView)
        
        pageControl.numberOfPages = messages.count
        pageControl.currentPage = 0
        pageControl.dotColor = UIColor(red: 110/255, green: 109/255, blue: 109/255, alpha: 1)
        pageControl.selectedDotColor = UIColor.whiteColor()
        pageControl.dotSize = 10
        pageControl.backgroundColor = UIColor.clearColor()
        view.addSubview(pageControl)
        
        signupButton.backgroundColor = UIColor(red: 19/255, green: 173/255, blue: 163/255, alpha: 1)
        signupButton.setTitle("Sign Up", forState: .Normal)
        signupButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        signupButton.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        signupButton.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        signupButton.addTarget(self, action: Selector("didTapSignup"), forControlEvents: UIControlEvents.TouchUpInside)

        view.addSubview(signupButton)

        loginButton.backgroundColor = UIColor(red: 19/255, green: 173/255, blue: 163/255, alpha: 1)
        loginButton.setTitle("Log In", forState: .Normal)
        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginButton.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        loginButton.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        loginButton.addTarget(self, action: Selector("didTapLogin"), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(loginButton)
        
        separator.backgroundColor = UIColor.blackColor()
        separator.alpha = 0.5
        view.addSubview(separator)
        
        self.layoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func layoutSubviews() {
        var superview : UIView = self.view
        
        for imageView in [currentImageView, nextImageView]  {
            imageView.mas_makeConstraints { (make) -> Void in
                make.edges.equalTo()(superview)
                return ()
            }
        }
        
        chatIcon.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(self.logo.mas_centerX)
            make.bottom.greaterThanOrEqualTo()(self.logo.mas_top).with().offset()(20)
            return ()
        }
        
        logo.mas_makeConstraints { (make) -> Void in
            make.top.lessThanOrEqualTo()(self.logo.mas_bottom)
            make.center.equalTo()(superview).centerOffset()(CGPointMake(0, -60))
            return ()
        }
        
        swipeView.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(superview)
            make.left.equalTo()(superview)
            make.right.equalTo()(superview)
            make.bottom.equalTo()([self.signupButton.mas_top, self.loginButton.mas_top])
            return ()
        }
        
        pageControl.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(superview)
            make.right.equalTo()(superview)
            make.height.greaterThanOrEqualTo()(50)
            var size = self.pageControl.sizeForNumberOfPages(self.messages.count)
            make.height.greaterThanOrEqualTo()(size.height)
            make.width.greaterThanOrEqualTo()(size.width)

            make.bottom.equalTo()([self.signupButton.mas_top, self.loginButton.mas_top]).with().offset()(-15)
            return ()
        }
        
        signupButton.mas_makeConstraints { (make) -> Void in
            var bottomLayoutGuide : AnyObject = self.bottomLayoutGuide;
            
            if let bottom = bottomLayoutGuide as? UIView {
                make.bottom.equalTo()(bottom.mas_top)
                make.bottom.equalTo()(self.loginButton)
                make.top.equalTo()(self.loginButton)
                make.width.equalTo()(self.loginButton)
                make.height.equalTo()(44);
                make.height.equalTo()(self.loginButton);
                make.left.equalTo()(superview.mas_left);
                make.right.equalTo()(self.loginButton.mas_left);
            }
        }
        
        loginButton.mas_makeConstraints { (make) -> Void in
            make.right.equalTo()(superview.mas_right)
            make.left.equalTo()(self.signupButton.mas_right)
            make.height.equalTo()(self.signupButton);
            make.width.equalTo()(self.signupButton)
            make.top.equalTo()(self.signupButton)
            make.bottom.equalTo()(self.signupButton)
        }
        
        separator.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(superview.mas_centerX)
            make.width.equalTo()(0.5)
            make.top.equalTo()(self.signupButton.mas_top).offset()(7)
            make.bottom.equalTo()(self.signupButton.mas_bottom).offset()(-7)
        }
    }
    
    func didTapSignup() {
        SignupWireFrame.presentSignupInterfaceFrom(self)
    }

    func didTapLogin() {
        LoginWireFrame.presentSignupInterfaceFrom(self)
    }
    
    // MARK: SwipeViewDataSource
    
    func numberOfItemsInSwipeView(swipeView: SwipeView!) -> Int {
        return messages.count
    }
    
    func swipeView(swipeView: SwipeView!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView! {
        var label : UILabel
        var reusingView : UIView
        
        if(view == nil) {
            reusingView = UIView(frame: swipeView.bounds)
            reusingView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
            
            label = UILabel(frame:reusingView.bounds)
            label.autoresizingMask = .FlexibleWidth | .FlexibleHeight
            label.backgroundColor = UIColor.clearColor()
            label.textAlignment = .Center
            label.textColor = UIColor.whiteColor()
            label.font = UIFont.systemFontOfSize(20)
            label.numberOfLines = 2
            label.lineBreakMode = .ByWordWrapping
            label.tag = 1
            
            reusingView.addSubview(label)
            
            label.mas_makeConstraints { (make) -> Void in
                make.center.equalTo()(reusingView).centerOffset()(CGPointMake(0, 30))
                make.height.equalTo()(60)
                make.left.equalTo()(reusingView)
                make.right.equalTo()(reusingView)

                return ()
            }
            
        } else {
            reusingView = view
            label = reusingView.viewWithTag(1) as UILabel
        }
        
        label.text = messages[index]
        
        return reusingView
    }
    
    func swipeViewItemSize(swipeView: SwipeView!) -> CGSize {
        return swipeView.bounds.size
    }
    
    func swipeViewDidScroll(swipeView: SwipeView!) {
        var indexes : (current:Int, next:Int)?
        
        if(currentScrollOffset < swipeView.scrollOffset) {
//            println("swiping forward")
            indexes = ( current:Int(floor(swipeView.scrollOffset)), next:Int(ceil(swipeView.scrollOffset)) )
        } else if(currentScrollOffset > swipeView.scrollOffset){
//            println("swiping back")
            indexes = ( current:Int(ceil(swipeView.scrollOffset)), next:Int(floor(swipeView.scrollOffset)) )
        }
        
        currentScrollOffset = swipeView.scrollOffset
        
        if let idx = indexes {
            if(idx.next >= 0 && idx.next < introImages.count && idx.current >= 0 && idx.current < introImages.count) {
                var nextImage = introImages[idx.next]
                var currentImage = introImages[idx.current]
                
                if(self.nextImageView.image != nextImage) {
                    self.nextImageView.image = nextImage
                    self.nextImageView.alpha = 1
                }
                
                if(self.currentImageView.image != currentImage) {
                    self.currentImageView.image = currentImage
                    self.currentImageView.alpha = 1
                }
                
                var alpha : Float = fabs(Float(swipeView.scrollOffset) - Float(idx.current))
//                println("current: \(idx.current) next: \(idx.next) alpha: \(alpha) ")
                self.currentImageView.alpha = CGFloat(1 - alpha)
            }
        }
    }
    
    func swipeViewCurrentItemIndexDidChange(swipeView: SwipeView!) {
        pageControl.currentPage = swipeView.currentItemIndex
    }
    
    func swipeViewDidEndDecelerating(swipeView: SwipeView!) {
        
        if(swipeView.currentItemIndex == introImages.count - 1 && self.chatIcon.alpha != 1) {
            UIView.animateWithDuration(0.20,
                delay : 0,
                options: UIViewAnimationOptions.CurveEaseOut,
                animations: {
                    self.chatIcon.transform = CGAffineTransformMakeScale(1.4, 1.4)
                    self.chatIcon.alpha = 1
                }, completion: { (value: Bool) in
                    UIView.animateWithDuration(0.20, animations: {
                        self.chatIcon.transform = CGAffineTransformMakeScale(1, 1)
                    })
            })

        }
    }

}

