
//
//  LinkDisplay.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-20.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements

class LinkDisplay {
    
    
    init( ctx : CGContext, portal : DiagramPortal, lnk : Link, document: Document ) {
        
        _portal = portal
        _ctx = ctx
        _lnk  = lnk
        _doc = document
        
        _model = _doc.models.get(_lnk.modelId)
        
        var t1 = _doc.models.get("N8RavzKGAqAEZwc1")
        
        debugPrintln("init linkdisplay end")
    }
    
    func draw() {
        
        let count = _lnk.segment.count
        
        if count > 1 {
            
            CGContextBeginPath(_ctx)
            
            var pt = _lnk.segment.get(0)
            var portalPt = _portal.pointFromDiagramToPortal(pt)
            CGContextMoveToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))
            
            for var idx = 1; idx < count; idx++ {
                pt = _lnk.segment.get(idx)
                portalPt = _portal.pointFromDiagramToPortal(pt)
                CGContextAddLineToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))
            }
            
            CGContextDrawPath(_ctx, kCGPathStroke)
        }
    }
    
    var _portal : DiagramPortal
    var _ctx : CGContext
    var _lnk : Link
    var _doc : Document
    var _model : Model!
}
