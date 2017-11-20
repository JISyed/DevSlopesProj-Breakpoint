//
//  LoginViewController.swift
//  Breakpoint
//
//  Created by Jibran Syed on 10/24/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController 
{
    @IBOutlet weak var txtFieldEmail: InsetTextField!
    @IBOutlet weak var txtFieldPassword: InsetTextField!
    
    
    
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txtFieldEmail.delegate = self
        txtFieldPassword.delegate = self
        
    }
    
    
    
    
    @IBAction func onSignInBtnPressed(_ sender: Any) 
    {
        // If there is text written in both
        if txtFieldEmail.text != nil && txtFieldPassword.text != nil
        {
            let email = txtFieldEmail.text!
            let password = txtFieldPassword.text!
            
            // Try to log in the user
            AuthService.instance.loginUser(withEmail: email, andPassword: password, onComplete: { (success, error) in
                if success
                {
                    print("User logged in")
                    self.dismiss(animated: true, completion: nil)
                }
                else    // Login failed
                {
                    print(String(describing: error?.localizedDescription))
                    // If login fails, register the given email and password and try to log them in again
                    AuthService.instance.registerUser(withEmail: email, andPassword: password, onComplete: { (registerSuccess, registerError) in
                        if registerSuccess
                        {
                            AuthService.instance.loginUser(withEmail: email, andPassword: password, onComplete: { (loginSuccess, loginError) in
                                print("Succesfully registered user")
                                self.dismiss(animated: true, completion: nil)
                            })
                        }
                        else // registration failed
                        {
                            print(String(describing: registerError?.localizedDescription))
                        }
                    })
                }
            })
        }
        
        
    }
    
    
    
    @IBAction func onCloseBtnPressed(_ sender: Any) 
    {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}


extension LoginViewController: UITextFieldDelegate
{
    
}

