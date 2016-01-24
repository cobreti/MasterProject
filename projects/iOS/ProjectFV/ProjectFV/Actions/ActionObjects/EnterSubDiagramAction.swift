//
//  EnterSubDiagramAction.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-16.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements

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

    var selectedElement: Element! {
        get {
            return _selectedElement
        }
    }

    init( subDiagramController : DiagramViewController, selectedElement: Element!, sender: AnyObject! ) {
        
        _subDiagramController = subDiagramController
        _selectedElement = selectedElement
        
        super.init(id: .EnterSubDiagram, sender: sender)
    }

    var _subDiagramController : DiagramViewController
    var _selectedElement : Element!
}