//
//  GroupFeedCell.swift
//  Breakpoint
//
//  Created by Jibran Syed on 10/26/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell 
{
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblFeedMessage: UILabel!
    
    
    func configureCell(profileImage: UIImage, email: String, message: String)
    {
        self.imgProfilePic.image = profileImage
        self.lblUserEmail.text = email
        self.lblFeedMessage.text = message
        
    }
}
