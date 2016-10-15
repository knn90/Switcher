//
//  ViewController.swift
//  SwitcherExample
//
//  Created by Khoi Nguyen Nguyen on 11/2/15.
//  Copyright © 2015 Khoi Nguyen Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, KNSwitcherChangeValueDelegate {
    var big:KNSwitcher!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let view = KNSwitcher(frame: , on: true)
         big = KNSwitcher(frame: CGRect(x: 20, y: 20, width: 250, height: 80),on: true)

        big.setImages(onImage: UIImage(named: "happy")!, offImage: UIImage(named: "sad")!)
        big.delegate = self;
        self.view.addSubview(big)
        
        let view1 = KNSwitcher(frame: CGRect(x: 150, y: 150, width: 100, height: 20),on: false)
        view1.selectedColor = UIColor.green
        view1.originalColor = UIColor.orange
        view1.selectedImage =  UIImage(named: "happy")!
        view1.originalImage =  UIImage(named: "sad")!
        view1.delegate = self;
        self.view.addSubview(view1)
        
        let view2 = KNSwitcher(frame: CGRect(x: 50, y: 250, width: 85, height: 30),on: true)
        view2.delegate = self;
        self.view.addSubview(view2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleBig(_ sender: AnyObject) {
        big.setOn(on: !big.on)
    }
 
    func switcherDidChangeValue(KNSwitch:KNSwitcher, value: Bool) {
        if value {
            
        }
    }
}

