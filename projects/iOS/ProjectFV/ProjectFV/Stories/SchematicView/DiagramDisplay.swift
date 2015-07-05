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
    
    var viewDrawingMode : ViewDrawingMode {
        get {
            return _drawingMode
        }
        set (value) {
            _drawingMode = value
        }
    }
    
    init(   targetRect : CGRect,
            diagram : Diagram,
            document : Document,
            portal : DiagramPortal,
            viewPinPt : PinPoint ) {
            
        _targetRect = targetRect
        _diagram = diagram
        _document = document
        _portal = portal
        _viewPinPoint = viewPinPt
    }
    
    func display(ctx : CGContext) {
        
        for (id, prim) in _diagram.primitives {
                        
            if let elm = prim as? Element {
                displayElement(ctx, elm: elm)
            }
            else if let lnk = prim as? Link {
                
                let linkDisplay = LinkDisplay(ctx: ctx, portal: _portal, lnk: lnk, document: _document)
                linkDisplay.viewDrawingMode = viewDrawingMode
                linkDisplay.draw()
            }
        }
        
//        drawPinningPoints(ctx)
//        drawPortalBBox(ctx)
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
        
        if let  model = _document.models.get(elm.modelId) {
                
            if let  path = model.filePath,
                    img = UIImage(named: "file.png", inBundle: NSBundle.mainBundle(), compatibleWithTraitCollection: nil) {
                drawElementIcon(rc, image: img)
            }
            
            if let  name = model.subDiagramName {

                var pt : Point = _viewPinPoint

                if (rc.width < 400 && rc.height < 400) || !portalRect.contains(pt) {
                    if let img = UIImage(named: "subdiagram.png", inBundle: NSBundle.mainBundle(), compatibleWithTraitCollection: nil) {
                        drawElementIcon(rc, image: img)
                    }
                }
            }
            
        }
        
        if let name = elm.name where viewDrawingMode == .Normal {
        
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
        
        if _diagram.selection.isSelected(elm) {
            
            rc = CGRect(
                x: portalRect.pos.x,
                y: portalRect.pos.y,
                width: portalRect.size.width,
                height: portalRect.size.height )
            rc.inset(dx: -5, dy: -5)
            CGContextSetRGBStrokeColor(ctx, 0, 0.5, 0, 1.0)
            CGContextStrokeRect(ctx, rc)
        }
    }
    
    func drawElementIcon(rect: CGRect, image: UIImage) {
        
        var imgWidth = max(rect.width / 3 - 2, 0)
        var imgHeight = rect.height / 3
        
        imgWidth = min(imgWidth, image.size.width)
        imgHeight = min(imgHeight, image.size.height)
        
        let imgSize = min(imgWidth, imgHeight)
        
        let rcImg = CGRect( x: rect.maxX-imgWidth-2, y: rect.minY+2, width: imgSize, height: imgSize )
        
        image.drawInRect(rcImg)
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
        
//        debugPrintln("vpp = \(_viewPinPoint.x), \(_viewPinPoint.y)")
//        debugPrintln("ppp = \(_portal.pinPoint.x), \(_portal.pinPoint.y)")
        
        pt = _portal.pointFromDiagramToPortal(_portal.pinPoint)
        
//        debugPrintln("pt = \(pt.x), \(pt.y)")
        
        rc = CGRect( origin: CGPoint(x: pt.x-7, y:pt.y-7), size: CGSize(width: 14, height: 14))

        CGContextSetRGBStrokeColor(ctx, 0.5, 0.0, 0.0, 1.0)
        CGContextStrokeEllipseInRect(ctx, rc)
    }
    
    
    var _targetRect : CGRect
    var _diagram : Diagram
    var _document : Document
    var _portal : DiagramPortal
    var _viewPinPoint : PinPoint
    var _drawingMode : ViewDrawingMode = .Normal
}
