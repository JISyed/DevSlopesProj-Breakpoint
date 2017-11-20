//
//  NewGroupViewController.swift
//  Breakpoint
//
//  Created by Jibran Syed on 10/25/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit
import Firebase

class NewGroupViewController: UIViewController 
{
    @IBOutlet weak var txtFieldTitle: InsetTextField!
    @IBOutlet weak var txtFieldDescription: InsetTextField!
    @IBOutlet weak var txtFieldAddPeople: InsetTextField!   // Email search
    @IBOutlet weak var tableUsersListing: UITableView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var lblAddedPeople: UILabel!
    
    
    var emails = [String]() // These are the results shown for searching a particular email
    var chosenUsers = [String]()    // All of the users chosen to be part of the group
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.txtFieldTitle.delegate = self
        self.txtFieldAddPeople.delegate = self
        self.txtFieldAddPeople.addTarget(self, action: #selector(onAddPeopleTextFieldEditingChanged), for: .editingChanged)   // Add an event for when the text editing changed
        self.txtFieldDescription.delegate = self
        self.tableUsersListing.delegate = self
        self.tableUsersListing.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
       
        // Hide the done button be default; there is no users selected
        btnDone.isHidden = true
    }
    
    
    
    @objc func onAddPeopleTextFieldEditingChanged()
    {
        if self.txtFieldAddPeople.text == ""
        {
            self.emails = []    // Clear results
            self.tableUsersListing.reloadData()
        }
        else
        {
            DataService.instance.getEmail(forSearchQuery: self.txtFieldAddPeople.text!, onComplete: { (returnedEmails) in
                self.emails = returnedEmails
                self.tableUsersListing.reloadData()
            })
        }
    }
    
    
    @IBAction func onDoneBtnPressed(_ sender: Any) 
    {
        let newTitle: String = txtFieldTitle.text ?? ""
        let newDescription: String = txtFieldDescription.text ?? ""
        if newTitle != "" && newDescription != ""
        {
            DataService.instance.getUIDs(forEmails: chosenUsers, onComplete: { (uids) in
                var allChosenUsers = uids
                allChosenUsers.append((Auth.auth().currentUser?.uid)!)  // Add yourself to the group automatically
                
                DataService.instance.createGroup(withTitle: newTitle, andDescription: newDescription, forUsersOfUIDs: allChosenUsers, onComplete: { (success) in
                    if success
                    {
                        self.dismiss(animated: true, completion: nil)
                    }
                    else
                    {
                        print("Group could not be created!!")
                    }
                })
            })
        }
        else
        {
            print("Provide title and description!")
        }
    }
    
    
    @IBAction func onCloseBtnPressed(_ sender: Any) 
    {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}


extension NewGroupViewController: UITextFieldDelegate
{
    
}


extension NewGroupViewController: UITableViewDelegate, UITableViewDataSource
{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return self.emails.count
    }
    
    
    // Returns a contructed cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_ID_NEW_GROUP_USER_CELL) as? NewGroupUserCell else {return UITableViewCell()}
        
        let image = UIImage(named: "defaultProfileImage")
        if chosenUsers.contains(emails[indexPath.row])
        {
            cell.configureCell(profileImage: image!, email: self.emails[indexPath.row], isSelected: true)
        }
        else
        {
            cell.configureCell(profileImage: image!, email: self.emails[indexPath.row], isSelected: false)
        }
        
        
        return cell
    }
    
    
    // Determines what happens at a selected cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
    {
        // Get the already existing cell
        guard let cell = tableView.cellForRow(at: indexPath) as? NewGroupUserCell else {return}
        
        // Don't add users that are already added
        let chosenUser: String = cell.lblUserEmail.text!
        if chosenUsers.contains(chosenUser) == false
        {
            chosenUsers.append(chosenUser)
            lblAddedPeople.text = chosenUsers.joined(separator: ", ")   // Join the members of the array with ", " separating each element
            btnDone.isHidden = false
        }
        else
        {
            // Keep everyone already chosen except this chosenUser
            // $0 is the current index shorthand
            chosenUsers = chosenUsers.filter({ $0 != chosenUser })
            
            // Reset the added people label to default "add people to your group" value if there are no chosen users
            if chosenUsers.count >= 1
            {
                lblAddedPeople.text = chosenUsers.joined(separator: ", ")
            }
            else
            {
                lblAddedPeople.text = "add people to your group"
                btnDone.isHidden = true
            }
            
        }
        
    }
    
}


