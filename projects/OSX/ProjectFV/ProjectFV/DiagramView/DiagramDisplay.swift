//
//  DiagramDisplay.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-03.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import AppKit
import DiagramElements

class DiagramDisplay {
    
    init(targetRect : NSRect, layer : DiagramLayer) {
        _targetRect = targetRect
        _layer = layer
        
        let xScaling = targetRect.width / CGFloat(_layer.width)
        let yScaling = targetRect.height / CGFloat(_layer.height)
        
        _scaling = min(xScaling, yScaling)
    }
    
    func display() {
        
        for (id, prim) in _layer.primitives {
            
            var bezier : NSBezierPath = NSBezierPath()
            
            if let elm = prim as? Element {
                if let  x = elm.x,
                        y = elm.y,
                        width = elm.width,
                        height = elm.height {
                            
                        var rc = NSMakeRect( CGFloat(x) * _scaling, CGFloat(y) * _scaling, CGFloat(width) * _scaling, CGFloat(height) * _scaling )
                        
                        bezier.appendBezierPathWithRect(rc)
                        bezier.stroke()
                }
            }
            else if let lnk = prim as? Link {
                if let  x = lnk.x,
                        y = lnk.y,
                        width = lnk.width,
                        height = lnk.height {
                        
                        var rc = NSMakeRect( CGFloat(x) * _scaling, CGFloat(y) * _scaling, CGFloat(width) * _scaling, CGFloat(height) * _scaling )
                        
                        bezier.appendBezierPathWithOvalInRect(rc)
                        bezier.stroke()
                }
            }
        }
    }
    
    var _scaling : CGFloat
    var _targetRect : NSRect
    var _layer : DiagramLayer
}
