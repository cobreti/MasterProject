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
    
    init(   targetRect : CGRect,
            layer : DiagramLayer,
            document : Document,
            portal : DiagramPortal,
            viewPinPt : PinPoint ) {
            
        _targetRect = targetRect
        _layer = layer
        _document = document
        _portal = portal
        _viewPinPoint = viewPinPt
    }
    
    func display(ctx : CGContext) {
        
        for (id, prim) in _layer.primitives {
                        
            if let elm = prim as? Element {
                displayElement(ctx, elm: elm)
            }
            else if let lnk = prim as? Link {
                
                let linkDisplay = LinkDisplay(ctx: ctx, portal: _portal, lnk: lnk, document: _document)
                linkDisplay.draw()
            }
        }
        
        drawPinningPoints(ctx)
        drawPortalBBox(ctx)
    }
    
    func displayElement( ctx: CGContext, elm : Element ) {
        
        let     x = elm.box.pos.x,
        y = elm.box.pos.y,
        width = elm.box.size.width,
        height = elm.box.size.height
        
        var portalRect = _portal.rectFromDiagramToPortal(elm.box)
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
    
    func drawPortalBBox( ctx : CGContext ) {

        CGContextSetRGBStrokeColor(ctx, 0.0, 0.0, 0.0, 1.0)
        
        let bbox = _portal.boundingBox
        CGContextStrokeRect(ctx, bbox.toCGRect())
        
        CGContextBeginPath(ctx)
        CGContextMoveToPoint(ctx, CGFloat(bbox.left), CGFloat(bbox.midY))
        CGContextAddLineToPoint(ctx, CGFloat(bbox.right), CGFloat(bbox.midY))
        CGContextStrokePath(ctx)
        
        CGContextBeginPath(ctx)
        CGContextMoveToPoint(ctx, CGFloat(bbox.midX), CGFloat(bbox.top))
        CGContextAddLineToPoint(ctx, CGFloat(bbox.midX), CGFloat(bbox.bottom))
        CGContextStrokePath(ctx)
    }
    
    func drawPinningPoints( ctx: CGContext) {
        
        var pt : Point = _viewPinPoint
        var rc = CGRect( origin: CGPoint(x: pt.x-5, y: pt.y-5), size: CGSize(width: 10, height: 10))
        
        CGContextSetRGBStrokeColor(ctx, 0.0, 0.5, 0.0, 1.0)
        CGContextStrokeEllipseInRect(ctx, rc)
        
        debugPrintln("vpp = \(_viewPinPoint.x), \(_viewPinPoint.y)")
        debugPrintln("ppp = \(_portal.pinPoint.x), \(_portal.pinPoint.y)")
        
        pt = _portal.pointFromDiagramToPortal(_portal.pinPoint)
        
        debugPrintln("pt = \(pt.x), \(pt.y)")
        
        rc = CGRect( origin: CGPoint(x: pt.x-7, y:pt.y-7), size: CGSize(width: 14, height: 14))

        CGContextSetRGBStrokeColor(ctx, 0.5, 0.0, 0.0, 1.0)
        CGContextStrokeEllipseInRect(ctx, rc)
    }
    
    
    var _targetRect : CGRect
    var _layer : DiagramLayer
    var _document : Document
    var _portal : DiagramPortal
    var _viewPinPoint : PinPoint
}
