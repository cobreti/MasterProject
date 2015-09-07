//
//  Action.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-11.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation


class Action {
    
    var traceline : String {
        get {
            return "\(header) \(description)\n"
        }
    }
    
    var header : String {
        get {
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.FullStyle
            formatter.timeStyle = NSDateFormatterStyle.FullStyle
            return "[\(formatter.stringFromDate(_timestamp)), \(_id.rawValue)]"
        }
    }
    
    var log : Bool {
        get {
            return true
        }
    }
    
    var description: String {
        get {
            return ""
        }
    }
    
    var id : ActionIdentifier {
        get {
            return _id
        }
    }
    
    var timestamp : NSDate {
        get {
            return _timestamp
        }
    }
    
    var sender: AnyObject {
        get {
            return _sender
        }
    }
    
    init( id: ActionIdentifier, sender: AnyObject! ) {
        _id = id
        _timestamp = NSDate()
        _sender = sender
    }
    
    private var _id : ActionIdentifier
    private var _timestamp : NSDate
    private var _sender : AnyObject!
}

