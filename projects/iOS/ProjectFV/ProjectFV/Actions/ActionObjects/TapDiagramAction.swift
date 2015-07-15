//
//  TapDiagramAction.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-14.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes

class TapDiagramAction : GestureAction {
    
    var pt : Point {
        get {
            return _pt
        }
    }
    
    override var description: String {
        get {
            return "tap diagram action at : (\(pt.x), \(pt.y))"
        }
    }
    
    init(pt: Point, sender: AnyObject) {
        
        _pt = pt
        
        super.init(id: .TapDiagram, state: .Ended, sender: sender)
    }
    
    var _pt : Point
}