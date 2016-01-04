//
//  ExitSubDiagramAction.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-16.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class ExitSubDiagramAction : Action {
    
    override var description: String {
        get {
            return "exit subdiagram \(_subDiagramViewController.diagram.name)"
        }
    }

    var subDiagramViewController : DiagramViewController {
        get {
            return _subDiagramViewController
        }
    }
    
    init( controller: DiagramViewController, sender: AnyObject! ) {
    
        _subDiagramViewController = controller
        
        super.init(id: .ExitSubDiagram, sender: sender)
    }
    
    var _subDiagramViewController : DiagramViewController
}
