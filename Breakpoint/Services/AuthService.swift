//
//  AuthService.swift
//  Breakpoint
//
//  Created by Jibran Syed on 10/24/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import Foundation
import Firebase

class AuthService
{
    // Singeton
    static let instance = AuthService()
    private init() {}
    
    
    // Data
    
    
    
    
    // Functions
    
    
    func registerUser(withEmail email: String, andPassword password: String, onComplete: @escaping CompletionHandlerWithError)
    {
        Auth.auth().createUser(withEmail: email, password: password) { (userOpt, error) in
            guard let user = userOpt else {
                onComplete(false, error)
                return
            }
            
            // providerID can be google, facebook, email, etc
            let userData = [FBDB_KEY_PROVIDER: user.providerID, FBDB_KEY_EMAIL: user.email ?? "invalid@email"] 
            
            DataService.instance.createUser(uid: user.uid, userData: userData)
            
            onComplete(true, nil)
        }
    }
    
    
    func loginUser(withEmail email: String, andPassword password: String, onComplete: @escaping CompletionHandlerWithError)
    {
        Auth.auth().signIn(withEmail: email, password: password) { (userOpt, error) in
            if error != nil 
            {
                onComplete(false, error)
                return
            }
            
            onComplete(true, nil)
        }
    }
    
    
}
