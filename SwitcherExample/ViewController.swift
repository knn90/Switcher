//
//  ViewController.swift
//  SwitcherExample
//
//  Created by Khoi Nguyen Nguyen on 11/2/15.
//  Copyright © 2015 Khoi Nguyen Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, KNSwitcherChangeValueDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = KNSwitcher(status: true)
        view.frame = CGRect(x: 0, y: 0, width: 160, height: 80)
        view.center = self.view.center;
        view.delegate = self;
        self.view.addSubview(view)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    func switcherDidChangeValue(value: Bool) {
        if value {
            
        }
    }
}

