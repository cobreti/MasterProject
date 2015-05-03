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

//        var bezier : NSBezierPath = NSBezierPath()
//        bezier.appendBezierPathWithRect(bounds)
//        
//        bezier.fill()
        
        if let layer = Application.instance().document.layers.get("DiagramLayout") {
            
            for prim in layer.primitives {
                
                var bezier : NSBezierPath = NSBezierPath()
                
                if let  x = prim.x,
                        y = prim.y,
                        width = prim.width,
                        height = prim.height {
                    var rc = NSMakeRect( CGFloat(x), CGFloat(y), CGFloat(width), CGFloat(height) )
                    
                    bezier.appendBezierPathWithRect(rc)
                    bezier.stroke()
                }
            }
        }
    }
    
    override var flipped : Bool {
        get {
            return true
        }
    }
}
