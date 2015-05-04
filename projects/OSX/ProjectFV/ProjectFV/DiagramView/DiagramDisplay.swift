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
        
        for prim in _layer.primitives {
            
            var bezier : NSBezierPath = NSBezierPath()
            
            if let  x = prim.x,
                    y = prim.y,
                    width = prim.width,
                    height = prim.height {
                        
                    var rc = NSMakeRect( CGFloat(x) * _scaling, CGFloat(y) * _scaling, CGFloat(width) * _scaling, CGFloat(height) * _scaling )
                    
                    bezier.appendBezierPathWithRect(rc)
                    bezier.stroke()
            }
        }
    }
    
    var _scaling : CGFloat
    var _targetRect : NSRect
    var _layer : DiagramLayer
}