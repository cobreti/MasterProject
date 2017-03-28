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
    
    func add( _ listener: ActionListener ) -> ListenerId {
        
        let id : ListenerId = _nextId + 1
        _nextId += 1
        _listeners[id] = listener
        
        return id
    }
    
    func send(_ action: Action) {
        
        for (_, listener) in _listeners {
            listener.onAction(action)
        }
    }
    
    fileprivate var _nextId : ListenerId = 1
    fileprivate var _listeners : [ListenerId:ActionListener] = [:]
}
