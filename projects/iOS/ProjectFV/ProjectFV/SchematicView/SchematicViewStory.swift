//
//  SchematicViewStory.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-06.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import DiagramElements

class SchematicViewStory : Story {
    
    override var view : UIView {
        get {
            return _controller.view
        }
    }
    
    init(diagramName : String) {
        
        _diagramName = diagramName
        _controller = SchematicViewController(nibName: "SchematicView", bundle: nil)
        
        let document = Application.instance().document
        _controller.diagramLayer = document.layers.get(_diagramName)

    }
    
    var _controller : SchematicViewController!
    var _diagramName : String!
}
