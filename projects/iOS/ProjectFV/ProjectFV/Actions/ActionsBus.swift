//
//  ActionsBus.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-11.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class ActionsBus {
    
    var listeners : ActionListeners {
        get {
            return _listeners
        }
    }
    
    init() {
        _listeners = ActionListeners()
    }
    
    func send( action: Action ) {
        
        debugPrintln(action.description)
        _listeners.send(action)
    }
    
    
    private var _listeners : ActionListeners
}
