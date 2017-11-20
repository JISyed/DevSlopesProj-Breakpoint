//
//  GroupsCell.swift
//  Breakpoint
//
//  Created by Jibran Syed on 10/25/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit

class GroupsCell: UITableViewCell 
{
    @IBOutlet weak var lblGroupTitle: UILabel!
    @IBOutlet weak var lblGroupDescription: UILabel!
    @IBOutlet weak var lblGroupMembers: UILabel!
    
    
    
    
    func configureCell(title: String, description: String, memberCount: Int)
    {
        self.lblGroupTitle.text = title
        self.lblGroupDescription.text = description
        self.lblGroupMembers.text = "\(memberCount) members"
    }
    
}
