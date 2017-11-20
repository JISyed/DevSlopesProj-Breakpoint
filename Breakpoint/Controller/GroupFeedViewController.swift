//
//  GroupFeedViewController.swift
//  Breakpoint
//
//  Created by Jibran Syed on 10/26/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedViewController: UIViewController 
{
    @IBOutlet weak var tableGroupFeed: UITableView!
    @IBOutlet weak var lblGroupMembers: UILabel!
    @IBOutlet weak var lblGroupTitle: UILabel!
    @IBOutlet weak var viewMessageBox: UIView!
    @IBOutlet weak var txtFieldNewGroupMessage: InsetTextField!
    @IBOutlet weak var btnSend: UIButton!
    
    
    var group: Group?
    var groupMessages = [Message]()
    
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableGroupFeed.delegate = self
        tableGroupFeed.dataSource = self
        
        self.view.bindToKeyboard()
        //self.viewMessageBox.bindToKeyboard()
        //self.txtFieldNewGroupMessage.bindToKeyboard()
        //self.btnSend.bindToKeyboard()
    }
    
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        
        lblGroupTitle.text = group?.title
        DataService.instance.getMemberEmailsForGroup(self.group!) { (returnedEmails) in
            self.lblGroupMembers.text = returnedEmails.joined(separator: ", ")
        }
        
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesForGroup(self.group!, onComplete: { (returnedGroupMessages) in
                self.groupMessages = returnedGroupMessages
                self.tableGroupFeed.reloadData()
                
                if self.groupMessages.count > 0
                {
                    let cellIndex = IndexPath(row: self.groupMessages.count - 1, section: 0)
                    self.tableGroupFeed.scrollToRow(at: cellIndex, at: .bottom, animated: true)
                }
            })
        }
        
    }
    
    
    
    func setupData(withGroup group: Group)
    {
        self.group = group
    }
    
    
    @IBAction func onBackBtnPressed(_ sender: Any) 
    {
        //dismiss(animated: true, completion: nil)
        dismissDetail()
    }
    
    
    @IBAction func onSendBtnPressed(_ sender: Any) 
    {
        if txtFieldNewGroupMessage.text != ""
        {
            self.txtFieldNewGroupMessage.isEnabled = false
            self.btnSend.isEnabled = false
            DataService.instance.uploadPost(withMessage: txtFieldNewGroupMessage.text!, forUID: Auth.auth().currentUser!.uid, withGroupKey: self.group?.key, onComplete: { (success) in
                if success
                {
                    self.txtFieldNewGroupMessage.isEnabled = true
                    self.btnSend.isEnabled = true
                    self.txtFieldNewGroupMessage.text = ""
                }
            })
        }
    }
    
    
    
}


extension GroupFeedViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int 
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return groupMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_ID_GROUP_FEED_CELL) as? GroupFeedCell else {return UITableViewCell() }
        
        let image = UIImage(named: "defaultProfileImage")
        let message = self.groupMessages[indexPath.row]
        
        DataService.instance.getUsername(forUID: message.senderId) { (returnedUsername) in
            cell.configureCell(profileImage: image!, email: returnedUsername, message: message.text)
        }
        
        return cell
    }
}


