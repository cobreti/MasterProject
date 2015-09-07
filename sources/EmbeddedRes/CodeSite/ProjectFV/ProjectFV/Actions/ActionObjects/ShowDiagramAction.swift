//
//  ShowDiagramAction.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-14.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements


class ShowDiagramAction : Action {
    
    var diagram: Diagram {
        get {
            return _diagram
        }
    }
    
    override var description : String {
        get {
            return "showing diagram \(_diagram.name)"
        }
    }
    
    init(diagram: Diagram, sender: AnyObject) {
        
        _diagram = diagram
        
        super.init(id: .ShowDiagram, sender: sender)
    }
    
    var _diagram : Diagram
}