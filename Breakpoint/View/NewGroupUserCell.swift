//
//  NewGroupUserCell.swift
//  Breakpoint
//
//  Created by Jibran Syed on 10/25/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit

class NewGroupUserCell: UITableViewCell 
{
    
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var imgCheckmark: UIImageView!
    
    var showing = false
    
    func configureCell(profileImage image: UIImage, email: String, isSelected: Bool)
    {
        self.imgUserProfile.image = image
        self.lblUserEmail.text = email
        
        if isSelected
        {
            self.imgCheckmark.isHidden = false
        }
        else
        {
            self.imgCheckmark.isHidden = true
        }
    }
    
    
    // Toggle the checkmark
    override func setSelected(_ selected: Bool, animated: Bool) 
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        // If we tapped on the cell
        if selected
        {
            if showing == false 
            {
                self.imgCheckmark.isHidden = false
                showing = true
            }
            else
            {
                self.imgCheckmark.isHidden = true
                showing = false
            }
        }
        
        
    }
    
    
    
}
