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
    
    init(targetRect : CGRect, layer : DiagramLayer) {
        _targetRect = targetRect
        _layer = layer
        
        _offset = Point(x: -_layer.box.pos.x, y: -_layer.box.pos.y)
        
        let xScaling = targetRect.width / CGFloat(_layer.box.size.width)
        let yScaling = targetRect.height / CGFloat(_layer.box.size.height)
        
        _scaling = min(xScaling, yScaling)
    }
    
    func display(ctx : CGContext) {
        
        for (id, prim) in _layer.primitives {
            
            
            if let elm = prim as? Element {
                displayElement(ctx, elm: elm)
            }
            else if let lnk = prim as? Link {
                
                displayLink(ctx, lnk: lnk)
            }
        }
    }
    
    func displayElement( ctx: CGContext, elm : Element ) {
        
        let     x = elm.box.pos.x,
        y = elm.box.pos.y,
        width = elm.box.size.width,
        height = elm.box.size.height
        
        var rc = CGRect( x: CGFloat(x + _offset.x) * _scaling, y: CGFloat(y + _offset.y) * _scaling, width: CGFloat(width) * _scaling, height: CGFloat(height) * _scaling )
        
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
    
    func displayLink( ctx : CGContext, lnk : Link ) {
        
        let count = lnk.segment.count
        
        if count > 1 {
            
            CGContextBeginPath(ctx)
            
            var pt = lnk.segment.get(0)
            CGContextMoveToPoint(ctx, CGFloat(pt.x + _offset.x) * _scaling, CGFloat(pt.y + _offset.y) * _scaling)
            
            for var idx = 1; idx < count; idx++ {
                pt = lnk.segment.get(idx)
                CGContextAddLineToPoint(ctx, CGFloat(pt.x + _offset.x) * _scaling, CGFloat(pt.y + _offset.y) * _scaling)
            }
     
            CGContextDrawPath(ctx, kCGPathStroke)
        }
    }
    
    var _scaling : CGFloat
    var _targetRect : CGRect
    var _layer : DiagramLayer
    var _offset : Point
}
