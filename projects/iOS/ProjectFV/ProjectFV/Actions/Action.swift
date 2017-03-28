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
            let formatter = DateFormatter()
            formatter.dateStyle = DateFormatter.Style.full
            formatter.timeStyle = DateFormatter.Style.full
            return "[\(formatter.string(from: _timestamp)), \(_id.rawValue)]"
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
    
    var timestamp : Date {
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
        _timestamp = Date()
        _sender = sender
    }
    
    fileprivate var _id : ActionIdentifier
    fileprivate var _timestamp : Date
    fileprivate var _sender : AnyObject!
}

