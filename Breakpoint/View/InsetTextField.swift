//
//  InsetTextField.swift
//  Breakpoint
//
//  Created by Jibran Syed on 10/24/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit

class InsetTextField: UITextField 
{
    private var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    
    
    override func awakeFromNib() 
    {
        let placeholderAttrStr = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
        self.attributedPlaceholder = placeholderAttrStr
        
        super.awakeFromNib()
    }
    
    
    // Where text is held without editing
    override func textRect(forBounds bounds: CGRect) -> CGRect 
    {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    
    // When you are typing text
    override func editingRect(forBounds bounds: CGRect) -> CGRect 
    {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    
    // For placeholder text when there is no text
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect 
    {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    
    
}
