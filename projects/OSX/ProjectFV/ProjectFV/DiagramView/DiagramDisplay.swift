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
        
        _diagramPortal = DiagramPortal(
            rcArea: Rect( x: Double(targetRect.origin.x), y: Double(targetRect.origin.y), width: Double(targetRect.size.width), height: Double(targetRect.size.height) ),
            diagramBox: _layer.box )
        
//        _offset = Point(x: -_layer.box.pos.x, y: -_layer.box.pos.y)
        
//        let xScaling = targetRect.width / CGFloat(_layer.box.size.width)
//        let yScaling = targetRect.height / CGFloat(_layer.box.size.height)
//        
//        _scaling = min(xScaling, yScaling)
    }
    
    func display() {
        
        for (id, prim) in _layer.primitives {
            
            
            if let elm = prim as? Element {
                displayElement(elm)
            }
            else if let lnk = prim as? Link {
                
                displayLink(lnk)
            }
        }
    }
    
    func displayElement( elm : Element ) {
        
        var bezier : NSBezierPath = NSBezierPath()
        
        var portalRect = _diagramPortal.rectFromDiagramToPortal(elm.box)
        var rc = NSMakeRect(
            CGFloat(portalRect.pos.x),
            CGFloat(portalRect.pos.y),
            CGFloat(portalRect.size.width),
            CGFloat(portalRect.size.height) )
        
        bezier.appendBezierPathWithRect(rc)
        bezier.stroke()

        if let name = elm.name {
            var parStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
            var strSize = name.sizeWithAttributes([
                NSParagraphStyleAttributeName: parStyle
                ])
            
            parStyle.alignment = NSTextAlignment.CenterTextAlignment
            
            rc.inset(dx: 0, dy: (rc.height - strSize.height)/2)
            
            name.drawInRect(rc, withAttributes: [
                NSParagraphStyleAttributeName: parStyle
                ])
        }
    }
    
    func displayLink( lnk : Link ) {
        
        var bezier : NSBezierPath = NSBezierPath()
        let count = lnk.segment.count
        
        if count > 1 {
            
            var pt = lnk.segment.get(0)
            var portalPt = _diagramPortal.pointFromDiagramToPortal(pt)
            bezier.moveToPoint(NSMakePoint( CGFloat(portalPt.x), CGFloat(portalPt.y)))
            
            for var idx = 1; idx < count; idx++ {
                pt = lnk.segment.get(idx)
                portalPt = _diagramPortal.pointFromDiagramToPortal(pt)
                bezier.lineToPoint(NSMakePoint( CGFloat(portalPt.x), CGFloat(portalPt.y)))
            }
            
            bezier.lineWidth - 1.0
            bezier.stroke()
        }
    }
    
    var _targetRect : NSRect
    var _layer : DiagramLayer
    var _diagramPortal : DiagramPortal
}
