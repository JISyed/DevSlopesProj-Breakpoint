//
//  DataService.swift
//  Breakpoint
//
//  Created by Jibran Syed on 10/24/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import Foundation
import Firebase


// Data Globals
let _APP_DB_BASE_ = Database.database().reference()



// Data Service
class DataService
{
    // Singleton
    static let instance = DataService()
    private init() {}
    
    
    // Data
    private var _REF_BASE = _APP_DB_BASE_
    private var _REF_USERS = _APP_DB_BASE_.child("users")
    private var _REF_GROUPS = _APP_DB_BASE_.child("groups")
    private var _REF_FEED = _APP_DB_BASE_.child("feed")
    
    
    var REF_BASE: DatabaseReference
    {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference
    {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference
    {
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference
    {
        return _REF_FEED
    }
    
    
    
    
    
    // Functions
    
    
    func createUser(uid: String, userData: Dictionary<String, Any>)
    {
        // Create a new user with the UID value,
        // Then that user will have its user data set
        // The UID is previded by Firebase if the user signs up for the app account
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, onComplete: @escaping CompletionHandler)
    {
        if groupKey != nil
        {
            REF_GROUPS.child(groupKey!).child(FBDB_KEY_GROUP_MESSAGES).childByAutoId().updateChildValues( [FBDB_KEY_CONTENT: message, FBDB_KEY_SENDER_ID: uid] )
            onComplete(true)
        }
        else
        {
            // Create a new child entry with an automatically generated ID
            REF_FEED.childByAutoId().updateChildValues( [FBDB_KEY_CONTENT: message, FBDB_KEY_SENDER_ID: uid] )
            onComplete(true)
        }
        
    }
    
    
    
    
    func getAllFeedMessages(onComplete: @escaping (_ messages: [Message]) -> Void )
    {
        var messageArray = [Message]()
        
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageShapshot) in
            guard let shapshot = feedMessageShapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for message in shapshot
            {
                let msgText = message.childSnapshot(forPath: FBDB_KEY_CONTENT).value as! String
                let senderId = message.childSnapshot(forPath: FBDB_KEY_SENDER_ID).value as! String
                let messageData = Message(text: msgText, senderId: senderId)
                messageArray.append(messageData)
            }
            
            onComplete(messageArray)
        }
    }
    
    
    
    func getUsername(forUID uid: String, onComplete: @escaping (_ username: String) -> Void )
    {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let snapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in snapshot
            {
                if user.key == uid
                {
                    onComplete(user.childSnapshot(forPath: FBDB_KEY_EMAIL).value as! String)
                }
            }
        }
    }
    
    
    
    func getEmail(forSearchQuery emailQuery: String, onComplete: @escaping (_ emails: [String]) -> Void )
    {
        var emailArray = [String]()
        
        // Observe for changes in value in all of "user" database
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let snapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in snapshot
            {
                // Similar to: email = user["email"].value, but Firebase does it this way instead
                let email = user.childSnapshot(forPath: FBDB_KEY_EMAIL).value as! String
                
                // If the searched email was found and it's not the current user (the current user shouldn't be searching himself)
                if email.contains(emailQuery) && email != Auth.auth().currentUser?.email
                {
                    emailArray.append(email)
                }
            }
            
            onComplete(emailArray)
        }
    }
    
    
    
    func getUIDs(forEmails emails: [String], onComplete: @escaping (_ uids: [String]) -> Void )
    {
        REF_USERS.observeSingleEvent(of: .value) { (usersSnapshot) in
            guard let snapshot = usersSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            var uids = [String]()
            
            for user in snapshot
            {
                let email = user.childSnapshot(forPath: FBDB_KEY_EMAIL).value as! String
                
                if emails.contains(email)
                {
                    uids.append(user.key)
                }
            }
            
            onComplete(uids)
        }
    }
    
    
    func createGroup(withTitle title: String, andDescription description: String, forUsersOfUIDs uids: [String], onComplete: @escaping CompletionHandler)
    {
        // Make new group with automatically created ID
        REF_GROUPS.childByAutoId().updateChildValues([FBDB_KEY_GROUP_TITLE: title, FBDB_KEY_GROUP_DESC: description, FBDB_KEY_GROUP_MEMBERS: uids])
        onComplete(true)
    }
    
    
    
    func getAllGroupsOfCurrentUser(onComplete: @escaping (_ groups: [Group]) -> Void )
    {
        var groupsArray = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
            guard let snapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for group in snapshot
            {
                let members = group.childSnapshot(forPath: FBDB_KEY_GROUP_MEMBERS).value as! [String]
                
                // Only list groups that the current user is a part of (not all groups)
                if members.contains((Auth.auth().currentUser?.uid)!)
                {
                    let title = group.childSnapshot(forPath: FBDB_KEY_GROUP_TITLE).value as! String
                    let desc = group.childSnapshot(forPath: FBDB_KEY_GROUP_DESC).value as! String
                    let groupData = Group(title: title, description: desc, key: group.key, memberCount: members.count, members: members)
                    groupsArray.append(groupData)
                }
            }
            onComplete(groupsArray)
        }
    }
    
    
    func getMemberEmailsForGroup(_ group: Group, onComplete: @escaping (_ emails: [String]) -> Void)
    {
        var emailArray = [String]()
        
        // Observe only checks once, not all of the time
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let snapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in snapshot
            {
                if group.members.contains(user.key)
                {
                    let email = user.childSnapshot(forPath: FBDB_KEY_EMAIL).value as! String
                    emailArray.append(email)
                }
            }
            
            onComplete(emailArray)
        }
    }
    
    
    func getAllMessagesForGroup(_ group: Group, onComplete: @escaping (_ messages: [Message]) -> Void)
    {
        var groupMessagesArray = [Message]()
        
        REF_GROUPS.child(group.key).child(FBDB_KEY_GROUP_MESSAGES).observeSingleEvent(of: .value) { (groupMessageSnapshot) in
            guard let snapshot = groupMessageSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for groupMessage in snapshot
            {
                let content = groupMessage.childSnapshot(forPath: FBDB_KEY_CONTENT).value as! String
                let senderId = groupMessage.childSnapshot(forPath: FBDB_KEY_SENDER_ID).value as! String
                let message = Message(text: content, senderId: senderId)
                groupMessagesArray.append(message)
            }
            
            onComplete(groupMessagesArray)
        }
    }
    
    
    
}
