//
//  UIViewControllerExt.swift
//  Breakpoint
//
//  Created by Jibran Syed on 10/26/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit

extension UIViewController
{
    private enum PresentationDirection
    {
        case right
        case left
    }
    
    
    private func createTransitionAnimation(withDirection direction: PresentationDirection) -> CATransition
    {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        
        switch direction 
        {
        case .right:
            transition.subtype = kCATransitionFromRight
            break
        case .left:
            transition.subtype = kCATransitionFromLeft
            break
        }
        
        return transition
    }
    
    
    
    func presentDetail(_ viewControllerToPresent: UIViewController)
    {
        let transition = self.createTransitionAnimation(withDirection: .right)
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    
    func dismissDetail()
    {
        let transition = self.createTransitionAnimation(withDirection: .left)
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
    
}
