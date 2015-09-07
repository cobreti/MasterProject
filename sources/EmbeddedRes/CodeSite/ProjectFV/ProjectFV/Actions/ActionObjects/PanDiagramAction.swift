//
//  PanDiagramAction.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-13.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes

class PanDiagramAction : GestureAction {
    
    var translation: Point {
        get {
            return _translation
        }
    }
    
    
    override var description: String {
        get {
            return "\(_state.rawValue) --> Translation = (\(_translation.x), \(_translation.y))"
        }
    }
    
    init(translation: Point, state: State, sender: AnyObject) {
        
        _translation = translation
        
        super.init(id: .PanDiagram, state: state, sender: sender)
    }
    
    var _translation : Point
}

