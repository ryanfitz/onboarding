//
//  ViewController.swift
//  FadeExample
//
//  Created by Ryan Fitzgerald on 9/18/14.
//  Copyright (c) 2014 rebase. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let overlayButton : UIButton = UIButton.buttonWithType(.Custom) as UIButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overlayButton.backgroundColor = UIColor.grayColor()
        overlayButton.setTitle("Overlay", forState: .Normal)
        overlayButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        view.addSubview(overlayButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

