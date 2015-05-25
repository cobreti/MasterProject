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
    
    init(targetRect : CGRect, layer : DiagramLayer, document : Document, portal : DiagramPortal) {
        _targetRect = targetRect
        _layer = layer
        _document = document
        _portal = portal
        
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
    
    
    var _targetRect : CGRect
    var _layer : DiagramLayer
    var _document : Document
    var _portal : DiagramPortal
}
