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
        
        let switcher = KNSwitcher(frame: CGRect(x: 100, y: 100, width: 200, height: 80), on: false)
        switcher.setImages(onImage: UIImage(named: "Checkmark"), offImage: UIImage(named: "Delete"))
        self.view.addSubview(switcher)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func switcherDidChangeValue(switcher:KNSwitcher, value: Bool) {
        if value {
            
        }
    }
}

