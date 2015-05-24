
//
//  LinkDisplay.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-20.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements
import Shapes

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
            
            drawEndPoints()
        }
    }

    func drawEndPoints() {

        switch (_lnk.type) {
            case LinkType.association:
                drawAssociationEndPoints()
            case LinkType.generalization:
                drawGeneralizationEndPoints()
            default:
                break
        }
    }

    func drawGeneralizationEndPoints() {
        
        let p1 = _lnk.segment.get(0)
        let p2 = _lnk.segment.get(1)
        var portalPt = _portal.pointFromDiagramToPortal(p1)
        
        let axisSystem = AxisSystem(p1: p1, p2: p2)
        
        var p : Point = p1
        
        CGContextBeginPath(_ctx)
            p = axisSystem.fromAxis(Point(x: 0, y: 0))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextMoveToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))
            
            p = axisSystem.fromAxis(Point(x: 15, y: 10))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextAddLineToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))
        
            p = axisSystem.fromAxis(Point(x: 15, y: -10))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextAddLineToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))
            
            CGContextClosePath(_ctx)
            CGContextSetRGBFillColor(_ctx, 1.0, 1.0, 1.0, 1.0)
        CGContextFillPath(_ctx)
        
        CGContextBeginPath(_ctx)
            p = axisSystem.fromAxis(Point(x: 0, y: 0))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextMoveToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))
            
            p = axisSystem.fromAxis(Point(x: 15, y: 10))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextAddLineToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))
        
            p = axisSystem.fromAxis(Point(x: 15, y: -10))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextAddLineToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))
            
            CGContextClosePath(_ctx)
            CGContextSetRGBStrokeColor(_ctx, 0.0, 0.0, 0.0, 1.0)
        CGContextStrokePath(_ctx)
    }

    func drawAssociationEndPoints() {

        let count = _lnk.segment.count

        if let  model = _model,
        startPt = model.linkEndPointFrom {

            if startPt.type == LinkEndPointType.shared {

                drawShared( _lnk.segment.get(0), p2: _lnk.segment.get(1) )
            }

            if startPt.type == LinkEndPointType.composited {

                drawComposition( _lnk.segment.get(0), p2: _lnk.segment.get(1) )
            }
        }


        if let  model = _model,
        EndPt = model.linkEndPointTo {

            if EndPt.type == LinkEndPointType.shared {

                drawShared( _lnk.segment.get(count-1), p2: _lnk.segment.get(count-2) )
            }

            if EndPt.type == LinkEndPointType.composited {

                drawComposition( _lnk.segment.get(count-1), p2: _lnk.segment.get(count-2) )
            }

        }
    }
    
    func drawComposition( p1 : Point, p2 : Point ) {
        
        var portalPt = _portal.pointFromDiagramToPortal(p1)
        
        let axisSystem = AxisSystem(p1: p1, p2: p2)

        var p : Point = p1

        CGContextBeginPath(_ctx)
            p = axisSystem.fromAxis(Point(x: 0, y: 0))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextMoveToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))

            p = axisSystem.fromAxis(Point(x: 10, y: 7))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextAddLineToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))

            p = axisSystem.fromAxis(Point(x: 20, y: 0))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextAddLineToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))

            p = axisSystem.fromAxis(Point(x: 10, y: -7))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextAddLineToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))

            CGContextClosePath(_ctx)
            CGContextSetRGBFillColor(_ctx, 0.0, 0.0, 0.0, 1.0)
        CGContextFillPath(_ctx)

        CGContextBeginPath(_ctx)
            p = axisSystem.fromAxis(Point(x: 0, y: 0))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextMoveToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))

            p = axisSystem.fromAxis(Point(x: 10, y: 7))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextAddLineToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))

            p = axisSystem.fromAxis(Point(x: 20, y: 0))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextAddLineToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))

            p = axisSystem.fromAxis(Point(x: 10, y: -7))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextAddLineToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))

            CGContextClosePath(_ctx)
            CGContextSetRGBStrokeColor(_ctx, 0.0, 0.0, 0.0, 1.0)
        CGContextStrokePath(_ctx)
    }
    
    func drawShared( p1 : Point, p2 : Point ) {
        
        var portalPt = _portal.pointFromDiagramToPortal(p1)
        
        let axisSystem = AxisSystem(p1: p1, p2: p2)
        
        var p : Point = p1
        
        CGContextBeginPath(_ctx)
            p = axisSystem.fromAxis(Point(x: 0, y: 0))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextMoveToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))

            p = axisSystem.fromAxis(Point(x: 10, y: 7))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextAddLineToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))

            p = axisSystem.fromAxis(Point(x: 20, y: 0))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextAddLineToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))

            p = axisSystem.fromAxis(Point(x: 10, y: -7))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextAddLineToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))

            CGContextClosePath(_ctx)
            CGContextSetRGBFillColor(_ctx, 1.0, 1.0, 1.0, 1.0)
        CGContextFillPath(_ctx)

        CGContextBeginPath(_ctx)
            p = axisSystem.fromAxis(Point(x: 0, y: 0))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextMoveToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))

            p = axisSystem.fromAxis(Point(x: 10, y: 7))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextAddLineToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))

            p = axisSystem.fromAxis(Point(x: 20, y: 0))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextAddLineToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))

            p = axisSystem.fromAxis(Point(x: 10, y: -7))
            portalPt = _portal.pointFromDiagramToPortal(p)
            CGContextAddLineToPoint(_ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))

            CGContextClosePath(_ctx)
            CGContextSetRGBStrokeColor(_ctx, 0.0, 0.0, 0.0, 1.0)
        CGContextStrokePath(_ctx)
    }
    
    var _portal : DiagramPortal
    var _ctx : CGContext
    var _lnk : Link
    var _doc : Document
    var _model : Model!
}
