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
        
        let switcher = KNSwitcher(frame: CGRect(x: 0, y: 0, width: 200, height: 40), on: false)
        self.view.addSubview(switcher)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleBig(_ sender: AnyObject) {
//        big.setOn(on: !big.on)
    }
 
    func switcherDidChangeValue(switcher:KNSwitcher, value: Bool) {
        if value {
            
        }
    }
}

