//
//  Switcher.swift
//  SwitcherExample
//
//  Created by Khoi Nguyen Nguyen on 11/2/15.
//  Copyright © 2015 Khoi Nguyen Nguyen. All rights reserved.
//

import UIKit

protocol SwitcherChangeValueDelegate {
    func switcherDidChangeValue(value:Bool)
}

class Switcher: UIView {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var leftSpace: NSLayoutConstraint!
    
    var delegate: SwitcherChangeValueDelegate?
    
    private var status:Bool = false
    
    private var originPosition:CGFloat = 0.0
    private var finalPosition:CGFloat = 0.0
    
    override func awakeFromNib() {
        setUpUI()
    }
    
    func setUpUI() {
        button.setImage(UIImage(named: "Delete"), forState: UIControlState.Normal)
    }
    
    override func layoutSubviews() {

    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        
        button.layer.cornerRadius = button.frame.height / 2
        originPosition = (self.frame.height - button.frame.height) / 2;
        finalPosition = self.frame.width - originPosition - self.button.frame.width;
        leftSpace.constant = originPosition
    }
    
    @IBAction func switcherButtonDidTouch(sender: AnyObject) {
        if status {

            animationSwitcherButton(status)
        } else {

            animationSwitcherButton(status)
        }
        status = !status;
        delegate?.switcherDidChangeValue(status)
    }
    
    func animationSwitcherButton(status:Bool) {
        if status {
            
            // Clear Shadow
            self.button.layer.shadowOffset = CGSizeZero
            self.button.layer.shadowOpacity = 0
            self.button.layer.shadowRadius = self.button.frame.height / 2
            self.button.layer.cornerRadius = self.button.frame.height / 2
            self.button.layer.shadowPath = nil
            
            // Rotate animation
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = 0.0
            rotateAnimation.toValue = CGFloat(M_PI)
            rotateAnimation.duration = 0.5
            rotateAnimation.cumulative = false;
            self.button.layer.addAnimation(rotateAnimation, forKey: "rotate")
            
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.button.setImage(UIImage(named: "Delete"), forState: UIControlState.Normal)
                self.leftSpace.constant = self.originPosition
                self.layoutIfNeeded()
                self.button.backgroundColor = UIColor(red: 243/255.0, green: 229/255.0, blue: 211/255.0, alpha: 1)
                }, completion: { (finish:Bool) -> Void in

            })

        } else {
            
            // Rotate animation
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = CGFloat(M_PI)
            rotateAnimation.toValue = 0.0
            rotateAnimation.duration = 0.5
            rotateAnimation.cumulative = false;
            self.button.layer.addAnimation(rotateAnimation, forKey: "rotate")

            // Translation animation
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.button.setImage(UIImage(named: "Checkmark"), forState: UIControlState.Normal)
                self.leftSpace.constant = self.finalPosition
                self.layoutIfNeeded()
                self.button.backgroundColor = UIColor(red: 126/255.0, green: 134/255.0, blue: 249/255.0, alpha: 1)
                }, completion: { (finish:Bool) -> Void in
                    self.button.layer.shadowOffset = CGSizeMake(0, 0.2)
                    self.button.layer.shadowOpacity = 0.3
                    self.button.layer.shadowRadius = 5.0
                    self.button.layer.cornerRadius = self.button.frame.height / 2
                    self.button.layer.shadowPath = UIBezierPath(roundedRect: self.button.layer.bounds, cornerRadius: self.button.frame.height / 2).CGPath
            })

        }
    }
}
