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
import Shapes

class DiagramDisplay {
    
    init(targetRect : NSRect, layer : DiagramLayer) {
        _targetRect = targetRect
        _layer = layer
        
        _offset = Point(x: -_layer.box.pos.x, y: -_layer.box.pos.y)
        
        let xScaling = targetRect.width / CGFloat(_layer.box.size.width)
        let yScaling = targetRect.height / CGFloat(_layer.box.size.height)
        
        _scaling = min(xScaling, yScaling)
    }
    
    func display() {
        
        for (id, prim) in _layer.primitives {
            
            var bezier : NSBezierPath = NSBezierPath()
            
            if let elm = prim as? Element {
                let     x = elm.box.pos.x,
                        y = elm.box.pos.y,
                        width = elm.box.size.width,
                        height = elm.box.size.height
                            
                var rc = NSMakeRect( CGFloat(x + _offset.x) * _scaling, CGFloat(y + _offset.y) * _scaling, CGFloat(width) * _scaling, CGFloat(height) * _scaling )
                
                bezier.appendBezierPathWithRect(rc)
                bezier.stroke()
            }
            else if let lnk = prim as? Link {
                
                displayLink(lnk)
            }
        }
    }
    
    func displayLink( lnk : Link ) {
        
        var bezier : NSBezierPath = NSBezierPath()
        let count = lnk.segment.count
        
        if count > 1 {
            
            var pt = lnk.segment.get(0)
            bezier.moveToPoint(NSMakePoint( CGFloat(pt.x + _offset.x) * _scaling, CGFloat(pt.y + _offset.y) * _scaling))
            
            for var idx = 1; idx < count; idx++ {
                pt = lnk.segment.get(idx)
                bezier.lineToPoint(NSMakePoint( CGFloat(pt.x + _offset.x) * _scaling, CGFloat(pt.y + _offset.y) * _scaling))
            }
            
            bezier.lineWidth - 1.0
            bezier.stroke()
        }
    }
    
    var _scaling : CGFloat
    var _targetRect : NSRect
    var _layer : DiagramLayer
    var _offset : Point
}
