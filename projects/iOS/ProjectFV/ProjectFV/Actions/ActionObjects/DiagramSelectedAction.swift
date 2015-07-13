//
//  DiagramSelectedAction.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-11.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class DiagramSelectedAction : Action {
    
    override var description: String {
        get {
            return "diagram selected : \(_diagramName)"
        }
    }
    
    var diagramName : String {
        get {
            return _diagramName
        }
    }
    
    init( name: String, sender : AnyObject! ) {
    
        _diagramName = name
        
        super.init(id: ActionIdentifier.DiagramSelected, sender: sender )
    }
    
    private var _diagramName : String
}
