//
//  CreatePostViewController.swift
//  Breakpoint
//
//  Created by Jibran Syed on 10/24/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit
import Firebase

class CreatePostViewController: UIViewController 
{
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var txtFieldMessage: UITextView!
    @IBOutlet weak var btnSend: UIButton!
    
    
    let placeholderText = "Say something here..."
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txtFieldMessage.delegate = self
        self.btnSend.bindToKeyboard()
    }
    
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        
        self.lblUserEmail.text = Auth.auth().currentUser?.email
    }
    
    
    @IBAction func onSendBtnPressed(_ sender: Any) 
    {
        if txtFieldMessage.text != nil && txtFieldMessage.text != self.placeholderText
        {
            btnSend.isEnabled = false   // Prevent multiple sends!
            let uid = Auth.auth().currentUser?.uid
            DataService.instance.uploadPost(withMessage: txtFieldMessage.text, forUID: uid!, withGroupKey: nil, onComplete: { (success) in
                self.btnSend.isEnabled = true
                if success
                {
                    self.dismiss(animated: true, completion: nil)
                }
                else // Send message failed
                {
                    print("Message could not be sent!")
                }
            })
        }
    }
    
    
    @IBAction func onCloseBtnPressed(_ sender: Any) 
    {
        dismiss(animated: true, completion: nil)
    }
    

}


extension CreatePostViewController: UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView) 
    {
        if textView.text == self.placeholderText
        {
            textView.text = ""
        }
    }
    
    
}

