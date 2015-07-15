//
//  GestureAction.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-14.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class GestureAction : Action {
    
    enum State : String {
        case Began = "Began"
        case Changed = "Changed"
        case Ended = "Ended"
    }

    var state: State {
        get {
            return _state
        }
    }

    override var log : Bool {
        get {
            return _state != .Changed
        }
    }

    init(id: ActionIdentifier, state: State, sender: AnyObject) {
        
        _state = state
        
        super.init(id: id, sender: sender)
    }

    var _state : State
}

