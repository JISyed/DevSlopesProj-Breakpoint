//
//  UIViewExt.swift
//  Breakpoint
//
//  Created by Jibran Syed on 10/25/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit

// Affects all UIView's and their child classes
extension UIView
{
    func bindToKeyboard()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(UIView.onKeyboardChanges(_:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    
    @objc
    func onKeyboardChanges(_ notification: NSNotification)
    {
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let beginningFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endingFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endingFrame.origin.y - beginningFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: { 
            self.frame.origin.y += deltaY    // Move this view in line with the keyboard
        }, completion: nil)
    }
    
}
