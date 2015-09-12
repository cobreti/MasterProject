//
//  ActionsListeners.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-11.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class ActionListeners {

    typealias ListenerId = Int
    
    func add( listener: ActionListener ) -> ListenerId {
        
        let id = _nextId++
        _listeners[id] = listener
        
        return id
    }
    
    func send(action: Action) {
        
        for (_, listener) in _listeners {
            listener.onAction(action)
        }
    }
    
    private var _nextId : ListenerId = 1
    private var _listeners : [ListenerId:ActionListener] = [:]
}
