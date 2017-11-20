//
//  AuthViewController.swift
//  Breakpoint
//
//  Created by Jibran Syed on 10/24/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit
import Firebase

class AuthViewController: UIViewController 
{
    
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) 
    {
        super.viewDidAppear(animated)
        
        // Dismiss this view if the user is logged in
        if Auth.auth().currentUser != nil
        {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
    @IBAction func onSignInWithFacebookPressed(_ sender: Any) 
    {
        
    }
    
    
    @IBAction func onSignInWithGooglePressed(_ sender: Any) 
    {
        
    }
    
    
    @IBAction func onSignInWithEmainPressed(_ sender: Any) 
    {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: STRY_BRD_LOGIN_VC)
        present(loginVC!, animated: true, completion: nil)
    }
    
    
    
}
