//
//  Switcher.swift
//  SwitcherExample
//
//  Created by Khoi Nguyen Nguyen on 11/2/15.
//  Copyright © 2015 Khoi Nguyen Nguyen. All rights reserved.
//

import UIKit

protocol KNSwitcherChangeValueDelegate {
    func switcherDidChangeValue(KNSwitch:KNSwitcher,value:Bool)
}



class KNSwitcher: UIView {

    var button: UIButton!
    var delegate: KNSwitcherChangeValueDelegate?
    
    var on:Bool = false
    var selectedColor:UIColor = UIColor(red: 126/255.0, green: 134/255.0, blue: 249/255.0, alpha: 1)
    var originalColor:UIColor = UIColor(red: 243/255.0, green: 229/255.0, blue: 211/255.0, alpha: 1)
    var originalImage:UIImage = UIImage(named: "Delete")!
    var selectedImage:UIImage = UIImage(named: "Checkmark")!
    
    private var offCenterPosition:CGPoint!
    private var onCenterPosition:CGPoint!
    
     init(frame: CGRect,on: Bool) {
        super.init(frame: frame)
        self.on = on
        self.backgroundColor = UIColor.white
        button = UIButton(type: .custom) // let preferred over var here
        button.frame =  CGRect(x: 0, y:0 , width: frame.height * 0.75, height: frame.height * 0.75 )
        button.center = CGPoint(x: button.frame.width/2 + 5, y: frame.height/2)
        button.addTarget(self, action: #selector(switcherButtonTouch(_:)), for: UIControlEvents.touchUpInside)
        
        button.setImage(originalImage, for: .normal)
        button.setImage(selectedImage, for: .selected)
        
        onCenterPosition = CGPoint(x:self.frame.width - (button.frame.width/2) - 5  , y: self.frame.height/2)
        offCenterPosition = CGPoint(x: button.frame.width/2 + 5 , y: self.frame.height/2)
        animationSwitcherButton()
        self.addSubview(button)
    }
    
    func setImages(onImage:UIImage , offImage :UIImage)
        {
            button.setImage(offImage, for: .normal)
            button.setImage(onImage, for: .selected)
        }
    func setOn(on:Bool)  {
        if(on != self.on)
        {
            self.on = on
            animationSwitcherButton()
        }
        else
        {
        self.on = on
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        button.layer.cornerRadius = button.frame.height / 2
 
        if on == true {
            self.button.backgroundColor = selectedColor
        } else {
            self.button.backgroundColor = originalColor
        }
    }
    


     func switcherButtonTouch(_ sender: AnyObject) {
        on = !on;
        animationSwitcherButton()
        delegate?.switcherDidChangeValue(KNSwitch: self, value: on)
    }
    
    func animationSwitcherButton() {
        if on == true {
            
            // Rotate animation
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = -CGFloat(M_PI)
            rotateAnimation.toValue = 0.0
            rotateAnimation.duration = 0.45
            rotateAnimation.isCumulative = false;
            self.button.layer.add(rotateAnimation, forKey: "rotate")
            
            // Translation animation
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                self.button.isSelected = true
                self.button.center = self.onCenterPosition
                self.layoutIfNeeded()
                self.button.backgroundColor = self.selectedColor
                }, completion: { (finish:Bool) -> Void in
                    self.button.layer.shadowOffset = CGSize(width: 0, height: 0.2)
                    self.button.layer.shadowOpacity = 0.3
                    self.button.layer.shadowRadius = 5.0
                    self.button.layer.cornerRadius = self.button.frame.height / 2
                    self.button.layer.shadowPath = UIBezierPath(roundedRect: self.button.layer.bounds, cornerRadius: self.button.frame.height / 2).cgPath
            })
        } else {
            
            // Clear Shadow
            self.button.layer.shadowOffset = CGSize.zero
            self.button.layer.shadowOpacity = 0
            self.button.layer.shadowRadius = self.button.frame.height / 2
            self.button.layer.cornerRadius = self.button.frame.height / 2
            self.button.layer.shadowPath = nil
            
            // Rotate animation
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = 0.0
            rotateAnimation.toValue = -CGFloat(M_PI)
            rotateAnimation.duration = 0.45
            rotateAnimation.isCumulative = false;
            self.button.layer.add(rotateAnimation, forKey: "rotate")
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                self.button.isSelected = false
                self.button.center = self.offCenterPosition
                self.layoutIfNeeded()
                self.button.backgroundColor = self.originalColor
                }, completion: { (finish:Bool) -> Void in
                    
            })

        }
    }
}
