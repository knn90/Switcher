//
//  ViewController.swift
//  SwitcherExample
//
//  Created by Khoi Nguyen Nguyen on 11/2/15.
//  Copyright © 2015 Khoi Nguyen Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SwitcherChangeValueDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view:Switcher = loadViewFromNib() as? Switcher {
            view.frame = CGRectMake(0, 0, 160, 80)
            view.center = self.view.center;
            view.delegate = self;
            self.view.addSubview(view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "Switcher", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    func switcherDidChangeValue(value: Bool) {
        if value {
            print("Yes")
        }
    }
}

