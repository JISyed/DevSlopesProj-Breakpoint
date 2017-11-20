//
//  Group.swift
//  Breakpoint
//
//  Created by Jibran Syed on 10/26/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import Foundation


class Group
{
    private var _title: String
    private var _description: String
    private var _key: String
    private var _memberCount: Int
    private var _members: [String]
    
    public var title: String
    {
        return _title
    }
    
    public var description: String
    {
        return _description
    }
    
    public var key: String
    {
        return _key
    }
    
    public var memberCount: Int
    {
        return _memberCount
    }
    
    public var members: [String]
    {
        return _members
    }
    
    init(title: String, description: String, key: String, memberCount: Int, members: [String]) 
    {
        _title = title
        _description = description
        _key = key
        _memberCount = memberCount
        _members = members
    }
    
}
