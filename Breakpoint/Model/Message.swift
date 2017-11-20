//
//  Message.swift
//  Breakpoint
//
//  Created by Jibran Syed on 10/25/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import Foundation


class Message
{
    private var _text: String
    private var _senderId: String
    
    var text: String
    {
        return self._text
    }
    
    var senderId: String
    {
        return self._senderId
    }
    
    
    init(text: String, senderId: String) 
    {
        _text = text
        _senderId = senderId
    }
    
}
