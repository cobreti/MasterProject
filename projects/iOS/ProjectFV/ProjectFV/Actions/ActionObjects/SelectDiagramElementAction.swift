//
//  SelectDiagramElementAction.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-14.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements


class SelectDiagramElementAction : Action {
    
    var element: Element {
        get {
            return _element
        }
    }
    
    override var description: String {
        get {
            return "diagram element selected: \(_element.name)"
        }
    }
    
    init(element: Element, sender: AnyObject) {
        
        _element = element
        
        super.init(id: .SelectDiagramElement, sender: sender)
    }
    
    var _element : Element
}
