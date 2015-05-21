
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
            
            if let  model = _model,
                    startPt = model.linkEndPointFrom {
                    
                if startPt.type == LinkEndPointType.shared {
                    
                    var pt = _lnk.segment.get(0)
                    var portalPt = _portal.pointFromDiagramToPortal(pt)

                    let x = CGFloat(portalPt.x)
                    let y = CGFloat(portalPt.y)
                    let rc = CGRect(x: x - 5, y: y - 5, width: 10, height: 10);
                    
                    CGContextSetRGBFillColor(_ctx, 0.0, 0.0, 0.0, 1.0)
                    CGContextBeginPath(_ctx)
                    CGContextStrokeEllipseInRect(_ctx, rc)
                    CGContextFillPath(_ctx)
                }

                if startPt.type == LinkEndPointType.composited {
                    
                    var pt = _lnk.segment.get(0)
                    var portalPt = _portal.pointFromDiagramToPortal(pt)

                    let x = CGFloat(portalPt.x)
                    let y = CGFloat(portalPt.y)
                    let rc = CGRect(x: x - 5, y: y - 5, width: 10, height: 10);

                    CGContextSetRGBFillColor(_ctx, 0.0, 0.0, 0.0, 1.0)
                    CGContextBeginPath(_ctx)
                    CGContextStrokeEllipseInRect(_ctx, rc)
                    CGContextFillEllipseInRect(_ctx, rc)
                    CGContextFillPath(_ctx)
                }


                if let  model = _model,
                    EndPt = model.linkEndPointTo {
                        
                    if EndPt.type == LinkEndPointType.shared {
                        
                        var pt = _lnk.segment.last
                        var portalPt = _portal.pointFromDiagramToPortal(pt)
                        
                        let x = CGFloat(portalPt.x)
                        let y = CGFloat(portalPt.y)
                        let rc = CGRect(x: x - 5, y: y - 5, width: 10, height: 10);
                        
                        CGContextSetRGBFillColor(_ctx, 0.0, 0.0, 0.0, 1.0)
                        CGContextBeginPath(_ctx)
                        CGContextStrokeEllipseInRect(_ctx, rc)
                        CGContextFillPath(_ctx)
                    }
                    
                    if EndPt.type == LinkEndPointType.composited {
                        
                        var pt = _lnk.segment.last
                        var portalPt = _portal.pointFromDiagramToPortal(pt)
                        
                        let x = CGFloat(portalPt.x)
                        let y = CGFloat(portalPt.y)
                        let rc = CGRect(x: x - 5, y: y - 5, width: 10, height: 10);
                        
                        CGContextSetRGBFillColor(_ctx, 0.0, 0.0, 0.0, 1.0)
                        CGContextBeginPath(_ctx)
                        CGContextStrokeEllipseInRect(_ctx, rc)
                        CGContextFillEllipseInRect(_ctx, rc)
                        CGContextFillPath(_ctx)
                    }
                        
                }

            }
        }
    }
    
    var _portal : DiagramPortal
    var _ctx : CGContext
    var _lnk : Link
    var _doc : Document
    var _model : Model!
}
