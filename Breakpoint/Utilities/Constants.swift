//
//  Constants.swift
//  Breakpoint
//
//  Created by Jibran Syed on 10/24/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import Foundation


// Typedefs

typealias CompletionHandlerWithError = (_ success: Bool, _ error: Error?) -> Void
typealias CompletionHandler = (_ success: Bool) -> Void



// Firebase Database Data Keys
let FBDB_KEY_CONTENT = "content"
let FBDB_KEY_SENDER_ID = "senderId"
let FBDB_KEY_EMAIL = "email"
let FBDB_KEY_PROVIDER = "provider"
let FBDB_KEY_GROUP_TITLE = "title"
let FBDB_KEY_GROUP_DESC = "description"
let FBDB_KEY_GROUP_MEMBERS = "members"
let FBDB_KEY_GROUP_MESSAGES = "messages"


// Storyboard IDs

let STRY_BRD_MAIN = "Main"
let STRY_BRD_AUTH_VC = "AuthViewController"
let STRY_BRD_LOGIN_VC = "LoginViewController"
let STRY_BRD_CREATE_POST_VC = "CreatePostViewController"
let STRY_BRD_NEW_GROUP_VC = "NewGroupViewController"
let STRY_BRD_GROUP_FEED_VC = "GroupFeedViewController"


// Table & Collection Cell Reuse Identifiers

let REUSE_ID_FEED_CELL = "feedCell"
let REUSE_ID_GROUPS_CELL = "groupsCell"
let REUSE_ID_PROFILE_CELL = "profileCell"
let REUSE_ID_NEW_GROUP_USER_CELL = "newGroupUserCell"
let REUSE_ID_GROUP_FEED_CELL = "groupFeedCell"


