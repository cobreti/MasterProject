//
//  DiagramView.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-03.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import AppKit
import DiagramElements

class DiagramView : NSView {
    
    override func drawRect(dirtyRect: NSRect) {
        
        if let layer = Application.instance().document.layers.get("DiagramLayout") {

            let dd = DiagramDisplay(targetRect: bounds, layer: layer)
            
            dd.display()
        }
    }
    
    override var flipped : Bool {
        get {
            return true
        }
    }
}
