//
//  EnterSubDiagramAction.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-16.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class EnterSubDiagramAction : Action {

    override var description: String {
        get {
            return "enter sub diagram \(_subDiagramController.diagram!.name)"
        }
    }

    var subDiagramController: DiagramViewController {
        get {
            return _subDiagramController
        }
    }

    init( subDiagramController : DiagramViewController, sender: AnyObject! ) {
        
        _subDiagramController = subDiagramController
        
        super.init(id: .EnterSubDiagram, sender: sender)
    }

    var _subDiagramController : DiagramViewController
}