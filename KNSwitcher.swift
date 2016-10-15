//
//  Switcher.swift
//  SwitcherExample
//
//  Created by Khoi Nguyen Nguyen on 11/2/15.
//  Copyright © 2015 Khoi Nguyen Nguyen. All rights reserved.
//

import UIKit

protocol KNSwitcherChangeValueDelegate {
    func switcherDidChangeValue(value:Bool)
}

private let selectedColor = UIColor(red: 126/255.0, green: 134/255.0, blue: 249/255.0, alpha: 1)
private let originalColor = UIColor(red: 243/255.0, green: 229/255.0, blue: 211/255.0, alpha: 1)

class KNSwitcher: UIView {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var leftSpace: NSLayoutConstraint!
    
    var delegate: KNSwitcherChangeValueDelegate?
    
    private var status:Bool = false
    
    private var originPosition:CGFloat = 0.0
    private var finalPosition:CGFloat = 0.0
    
    
    private var view: UIView!
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        xibSetup()
        setUpUI()
    }
    
    convenience init(status: Bool) {
        self.init()
        self.status = status
        self.button.isSelected = status
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpUI() {
        button.setImage(UIImage(named: "Delete"), for: .normal)
        button.setImage(UIImage(named: "Checkmark"), for: .selected)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        button.layer.cornerRadius = button.frame.height / 2
        originPosition = (self.frame.height - button.frame.height) / 2;
        finalPosition = self.frame.width - originPosition - self.button.frame.width;
        if status {
            leftSpace.constant = finalPosition
            self.button.backgroundColor = selectedColor
        } else {
            self.button.backgroundColor = originalColor
            leftSpace.constant = originPosition
        }
        
        
    }
    
    private func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "KNSwitcher", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
        
    }

    @IBAction func switcherButtonTouch(_ sender: AnyObject) {
        status = !status;
        animationSwitcherButton()
        
        delegate?.switcherDidChangeValue(value: status)
    }
    
    func animationSwitcherButton() {
        if status {
            
            // Rotate animation
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = -CGFloat(M_PI)
            rotateAnimation.toValue = 0.0
            rotateAnimation.duration = 0.5
            rotateAnimation.isCumulative = false;
            self.button.layer.add(rotateAnimation, forKey: "rotate")
            
            // Translation animation
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                self.button.isSelected = true
                self.leftSpace.constant = self.finalPosition
                self.layoutIfNeeded()
                self.button.backgroundColor = selectedColor
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
            rotateAnimation.duration = 0.5
            rotateAnimation.isCumulative = false;
            self.button.layer.add(rotateAnimation, forKey: "rotate")
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                self.button.isSelected = false
                self.leftSpace.constant = self.originPosition
                self.layoutIfNeeded()
                self.button.backgroundColor = originalColor
                }, completion: { (finish:Bool) -> Void in
                    
            })

        }
    }
}
