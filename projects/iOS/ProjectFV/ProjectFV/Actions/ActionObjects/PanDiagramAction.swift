//
//  PanDiagramAction.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-13.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes

class PanDiagramAction : Action {
    
    enum State : String {
        case Began = "Began"
        case Changed = "Changed"
        case Ended = "Ended"
    }
    
    var translation: Point {
        get {
            return _translation
        }
    }
    
    override var log : Bool {
        get {
            return _state != .Changed
        }
    }
    
    var state: State {
        get {
            return _state
        }
    }
    
    override var description: String {
        get {
            return "\(_state.rawValue) --> Translation = (\(_translation.x), \(_translation.y))"
        }
    }
    
    init(translation: Point, state: State, sender: AnyObject) {
        
        _translation = translation
        _state = state
        
        super.init(id: .PanDiagram, sender: sender)
    }
    
    var _translation : Point
    var _state : State
}

