//
//  DiagramDisplay.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-15.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import DiagramElements
import Shapes

class DiagramDisplay {
    
    init(targetRect : CGRect, layer : DiagramLayer, document : Document) {
        _targetRect = targetRect
        _layer = layer
        _document = document
        
        _diagramPortal = DiagramPortal(
            rcArea: Rect( x: Double(targetRect.origin.x), y: Double(targetRect.origin.y), width: Double(targetRect.size.width), height: Double(targetRect.size.height) ),
            diagramBox: _layer.box )
    }
    
    func display(ctx : CGContext) {
        
        for (id, prim) in _layer.primitives {
            
            
            if let elm = prim as? Element {
                displayElement(ctx, elm: elm)
            }
            else if let lnk = prim as? Link {
                
                let linkDisplay = LinkDisplay(ctx: ctx, portal: _diagramPortal, lnk: lnk, document: _document)
                linkDisplay.draw()
//                displayLink(ctx, lnk: lnk)
            }
        }
    }
    
    func displayElement( ctx: CGContext, elm : Element ) {
        
        let     x = elm.box.pos.x,
        y = elm.box.pos.y,
        width = elm.box.size.width,
        height = elm.box.size.height
        
        var portalRect = _diagramPortal.rectFromDiagramToPortal(elm.box)
        var rc = CGRect(
            x: portalRect.pos.x,
            y: portalRect.pos.y,
            width: portalRect.size.width,
            height: portalRect.size.height )
        
        CGContextStrokeRect(ctx, rc)
        
        if let name = elm.name {
            var parStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
            var strSize = name.sizeWithAttributes([
                NSParagraphStyleAttributeName: parStyle
                ])
            
            parStyle.alignment = NSTextAlignment.Center
            
            rc.inset(dx: 0, dy: (rc.height - strSize.height)/2)
            
            name.drawInRect(rc, withAttributes: [
                NSParagraphStyleAttributeName: parStyle
                ])
        }
    }
    
//    func displayLink( ctx : CGContext, lnk : Link ) {
//        
//        let count = lnk.segment.count
//        
//        if count > 1 {
//            
//            CGContextBeginPath(ctx)
//            
//            var pt = lnk.segment.get(0)
//            var portalPt = _diagramPortal.pointFromDiagramToPortal(pt)
//            CGContextMoveToPoint(ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))
//            
//            for var idx = 1; idx < count; idx++ {
//                pt = lnk.segment.get(idx)
//                portalPt = _diagramPortal.pointFromDiagramToPortal(pt)
//                CGContextAddLineToPoint(ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))
//            }
//     
//            CGContextDrawPath(ctx, kCGPathStroke)
//        }
//    }
    
//    var _scaling : CGFloat
    var _targetRect : CGRect
    var _layer : DiagramLayer
//    var _offset : Point
    var _diagramPortal : DiagramPortal
    var _document : Document
}
