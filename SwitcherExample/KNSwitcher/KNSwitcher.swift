//
//  Switcher.swift
//  SwitcherExample
//
//  Created by Khoi Nguyen Nguyen on 11/2/15.
//  Copyright © 2015 Khoi Nguyen Nguyen. All rights reserved.
//

import UIKit

protocol KNSwitcherChangeValueDelegate {
    func switcherDidChangeValue(switcher: KNSwitcher,value: Bool)
}

class KNSwitcher: UIView {

    var button: UIButton!
    var buttonLeftConstraint: NSLayoutConstraint!
    var delegate: KNSwitcherChangeValueDelegate?
    
    @IBInspectable var on: Bool = false
    @IBInspectable var originalImage:UIImage?
    @IBInspectable var selectedImage:UIImage?
    @IBInspectable var selectedColor:UIColor = UIColor(red: 126/255.0, green: 134/255.0, blue: 249/255.0, alpha: 1)
    @IBInspectable var originalColor:UIColor = UIColor(red: 243/255.0, green: 229/255.0, blue: 211/255.0, alpha: 1)
    
    private var offCenterPosition: CGFloat!
    private var onCenterPosition: CGFloat!
    
     init(frame: CGRect, on: Bool) {
        super.init(frame: frame)
        self.on = on
        commonInit()
    }
    
    override func awakeFromNib() {
        commonInit()
    }
    
    private func commonInit() {
        button = UIButton(type: .custom)
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(switcherButtonTouch(_:)), for: UIControlEvents.touchUpInside)
        button.setImage(originalImage, for: .normal)
        button.setImage(selectedImage, for: .selected)
        offCenterPosition = self.bounds.height * 0.1
        onCenterPosition = self.bounds.width - (self.bounds.height * 0.9)
        
        if on == true {
            self.button.backgroundColor = selectedColor
        } else {
            self.button.backgroundColor = originalColor
        }
        
        if self.backgroundColor == nil {
            self.backgroundColor = .white
        }
        initLayout()
        animationSwitcherButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
        self.clipsToBounds = true
        button.layer.cornerRadius = button.bounds.height / 2
    }
    
    private func initLayout() {
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        buttonLeftConstraint = button.leftAnchor.constraint(equalTo: self.leftAnchor)
        buttonLeftConstraint.isActive = true
        button.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1).isActive = true
    }
    
    func setImages(onImage:UIImage? , offImage :UIImage?) {
            button.setImage(offImage, for: .normal)
            button.setImage(onImage, for: .selected)
        }   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func switcherButtonTouch(_ sender: AnyObject) {
        on = !on
        animationSwitcherButton()
        delegate?.switcherDidChangeValue(switcher: self, value: on)
    }
    
    func animationSwitcherButton() {
        if on == true {
            // Rotate animation
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = -CGFloat(Double.pi)
            rotateAnimation.toValue = 0.0
            rotateAnimation.duration = 0.45
            rotateAnimation.isCumulative = false;
            self.button.layer.add(rotateAnimation, forKey: "rotate")
            
            // Translation animation
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                self.button.isSelected = true
                self.buttonLeftConstraint.constant = self.onCenterPosition
                self.layoutIfNeeded()
                self.button.backgroundColor = self.selectedColor
                }, completion: { (finish:Bool) -> Void in
                    self.button.layer.shadowOffset = CGSize(width: 0, height: 0.2)
                    self.button.layer.shadowOpacity = 0.3
                    self.button.layer.shadowRadius = self.offCenterPosition
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
            rotateAnimation.toValue = -CGFloat(Double.pi)
            rotateAnimation.duration = 0.45
            rotateAnimation.isCumulative = false;
            self.button.layer.add(rotateAnimation, forKey: "rotate")
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                self.button.isSelected = false
                self.buttonLeftConstraint.constant = self.offCenterPosition
                self.layoutIfNeeded()
                self.button.backgroundColor = self.originalColor
                }, completion: { (finish:Bool) -> Void in
            })
        }
    }
}
