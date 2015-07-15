//
//  ZoomDiagramAction.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-14.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes

class ZoomDiagramAction : GestureAction {
    
    var scale: CGFloat {
        get {
            return _scale
        }
    }
    
    var velocity: CGFloat {
        get {
            return _velocity
        }
    }
    
    override var description: String {
        get {
            return "diagram zoom --> scale = \(_scale), velocity = \(velocity)"
        }
    }
    
    init(   scale: CGFloat,
            velocity: CGFloat,
            state: State,
            sender: AnyObject ) {
                
        _scale = scale
        _velocity = velocity
        
        super.init(id: .ZoomDiagram, state: state, sender: sender)
    }
    
    var _scale : CGFloat
    var _velocity : CGFloat
}

