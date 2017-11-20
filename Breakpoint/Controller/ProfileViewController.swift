//
//  ProfileViewController.swift
//  Breakpoint
//
//  Created by Jibran Syed on 10/24/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController 
{
    
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var tableProfile: UITableView!
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        
        self.lblUserEmail.text = Auth.auth().currentUser?.email
    }
    
    
    
    @IBAction func onSignOutBtnPressed(_ sender: Any) 
    {
        // Action sheets show up in the bottom, not the center of the screen
        let logoutPopup = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (buttonTapped) in
            do
            {
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: STRY_BRD_AUTH_VC) as? AuthViewController
                self.present(authVC!, animated: true, completion: nil)
            }
            catch
            {
                print(error)
            }
        }
        logoutPopup.addAction(logoutAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        logoutPopup.addAction(cancelAction)
        
        present(logoutPopup, animated: true, completion: nil)
        
    }
    
    
    
}
