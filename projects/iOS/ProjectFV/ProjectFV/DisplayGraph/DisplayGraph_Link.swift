//
// Created by Danny Thibaudeau on 15-08-15.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import Shapes
import DiagramElements

class DisplayGraph_Link : DisplayGraphItem {

    var fromEndType : LinkEndPointType {
        get {
            return _fromType
        }
        set (value) {
            _fromType = value
        }
    }

    var toEndType : LinkEndPointType {
        get {
            return _toType
        }
        set (value) {
            _toType = value
        }
    }

    init(pts: Polyline, type: LinkType) {

        _pts = pts
        _type = type
    }

    override func draw(params: DisplayGraphDrawParams) {

        let count = _pts.count

        if count > 1 {

            CGContextBeginPath(params.context)

            var pt = _pts.get(0)
            var portalPt = params.portal.pointFromDiagramToPortal(pt)
            CGContextMoveToPoint(params.context, CGFloat(portalPt.x), CGFloat(portalPt.y))

            for var idx = 1; idx < count; idx++ {
                pt = _pts.get(idx)
                portalPt = params.portal.pointFromDiagramToPortal(pt)
                CGContextAddLineToPoint(params.context, CGFloat(portalPt.x), CGFloat(portalPt.y))
            }

            CGContextDrawPath(params.context, CGPathDrawingMode.Stroke)

//            switch _type {
//
//                case .generalization:
////                    drawGeneralizationEndPoints(ctx, portal: portal)
//                    break
//                case .association:
//                    drawAssociationEndPoints(ctx, portal: portal)
//                default:
//                    break
//            }
        }
    }

//    func drawGeneralizationEndPoints(ctx: CGContext, portal: DiagramPortal) {
//
//        let p1 = _pts.get(0)
//        let p2 = _pts.get(1)
//        var portalPt = portal.pointFromDiagramToPortal(p1)
//        var portalEndPt1 = portal.pointFromDiagramToPortal(p1)
//        var portalEndPt2 = portal.pointFromDiagramToPortal(p2)
//
//        let axisSystem = AxisSystem(p1: portalEndPt1, p2: portalEndPt2)
//
//        var p : Point = p1
//
//        CGContextBeginPath(ctx)
//        p = axisSystem.fromAxis(Point(x: 0, y: 0))
//        CGContextMoveToPoint(ctx, p.x, p.y)
//
//        p = axisSystem.fromAxis(Point(x: 15, y: 10))
//        CGContextAddLineToPoint(ctx, p.x, p.y)
//
//        p = axisSystem.fromAxis(Point(x: 15, y: -10))
//        CGContextAddLineToPoint(ctx, p.x, p.y)
//
//        CGContextClosePath(ctx)
//        CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0)
//        CGContextFillPath(ctx)
//
//        CGContextBeginPath(ctx)
//        p = axisSystem.fromAxis(Point(x: 0, y: 0))
//        CGContextMoveToPoint(ctx, p.x, p.y)
//
//        p = axisSystem.fromAxis(Point(x: 15, y: 10))
//        CGContextAddLineToPoint(ctx, p.x, p.y)
//
//        p = axisSystem.fromAxis(Point(x: 15, y: -10))
//        CGContextAddLineToPoint(ctx, p.x, p.y)
//
//        CGContextClosePath(ctx)
//        CGContextSetRGBStrokeColor(ctx, 0.0, 0.0, 0.0, 1.0)
//        CGContextStrokePath(ctx)
//    }

//    func drawAssociationEndPoints(ctx: CGContext, portal: DiagramPortal) {
//
//        let count = _pts.count
//
//        switch _fromType {
//            case .shared:
//                drawShared( ctx, portal: portal, p1: _pts.get(0), p2: _pts.get(1) )
//            case .composited:
//                drawComposition( ctx, portal: portal, p1: _pts.get(0), p2: _pts.get(1) )
//            default:
//                break
//        }
//
//        switch _toType {
//            case .shared:
//                drawShared( ctx, portal: portal, p1: _pts.get(count-1), p2: _pts.get(count-2) )
//                break
//            case .composited:
//                drawComposition( ctx, portal: portal, p1: _pts.get(count-1), p2: _pts.get(count-2) )
//                break
//            default:
//                break
//        }
//    }
//
//    func drawComposition( ctx: CGContext, portal: DiagramPortal, p1 : Point, p2 : Point ) {
//
//        var portalPt = portal.pointFromDiagramToPortal(p1)
//
//        var portalEndPt1 = portal.pointFromDiagramToPortal(p1)
//        var portalEndPt2 = portal.pointFromDiagramToPortal(p2)
//
//        let axisSystem = AxisSystem(p1: portalEndPt1, p2: portalEndPt2)
//
//        var p : Point = p1
//        var p2 : Point = Point(x: 0,y: 0)
//
//        CGContextBeginPath(ctx)
//        p = axisSystem.fromAxis(Point(x: 0, y: 0))
//        CGContextMoveToPoint(ctx, p.x, p.y)
//
//        p = axisSystem.fromAxis(Point(x: 10, y: 7))
//        CGContextAddLineToPoint(ctx, p.x, p.y)
//
//        p = axisSystem.fromAxis(Point(x: 20, y: 0))
//        CGContextAddLineToPoint(ctx, p.x, p.y)
//
//        p = axisSystem.fromAxis(Point(x: 10, y: -7))
//        CGContextAddLineToPoint(ctx, p.x, p.y)
//
//        CGContextClosePath(ctx)
//        CGContextSetRGBFillColor(ctx, 0.0, 0.0, 0.0, 1.0)
//        CGContextFillPath(ctx)
//
//        CGContextBeginPath(ctx)
//        p = axisSystem.fromAxis(Point(x: 0, y: 0))
//        CGContextMoveToPoint(ctx, p.x, p.y)
//
//        p = axisSystem.fromAxis(Point(x: 10, y: 7))
//        CGContextAddLineToPoint(ctx, p.x, p.y)
//
//        p = axisSystem.fromAxis(Point(x: 20, y: 0))
//        CGContextAddLineToPoint(ctx, p.x, p.y)
//
//        p = axisSystem.fromAxis(Point(x: 10, y: -7))
//        CGContextAddLineToPoint(ctx, p.x, p.y)
//
//        CGContextClosePath(ctx)
//        CGContextSetRGBStrokeColor(ctx, 0.0, 0.0, 0.0, 1.0)
//        CGContextStrokePath(ctx)
//    }
//
//    func drawShared( ctx: CGContext, portal: DiagramPortal, p1 : Point, p2 : Point ) {
//
//        var portalPt = portal.pointFromDiagramToPortal(p1)
//        var portalEndPt1 = portal.pointFromDiagramToPortal(p1)
//        var portalEndPt2 = portal.pointFromDiagramToPortal(p2)
//
//        let axisSystem = AxisSystem(p1: portalEndPt1, p2: portalEndPt2)
//
//        var p : Point = p1
//
//        CGContextBeginPath(ctx)
//        p = axisSystem.fromAxis(Point(x: 0, y: 0))
//        CGContextMoveToPoint(ctx, p.x, p.y)
//
//        p = axisSystem.fromAxis(Point(x: 10, y: 7))
//        CGContextAddLineToPoint(ctx, p.x, p.y)
//
//        p = axisSystem.fromAxis(Point(x: 20, y: 0))
//        CGContextAddLineToPoint(ctx, p.x, p.y)
//
//        p = axisSystem.fromAxis(Point(x: 10, y: -7))
//        CGContextAddLineToPoint(ctx, p.x, p.y)
//
//        CGContextClosePath(ctx)
//        CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0)
//        CGContextFillPath(ctx)
//
//        CGContextBeginPath(ctx)
//        p = axisSystem.fromAxis(Point(x: 0, y: 0))
//        CGContextMoveToPoint(ctx, p.x, p.y)
//
//        p = axisSystem.fromAxis(Point(x: 10, y: 7))
//        CGContextAddLineToPoint(ctx, p.x, p.y)
//
//        p = axisSystem.fromAxis(Point(x: 20, y: 0))
//        CGContextAddLineToPoint(ctx, p.x, p.y)
//
//        p = axisSystem.fromAxis(Point(x: 10, y: -7))
//        CGContextAddLineToPoint(ctx, p.x, p.y)
//
//        CGContextClosePath(ctx)
//        CGContextSetRGBStrokeColor(ctx, 0.0, 0.0, 0.0, 1.0)
//        CGContextStrokePath(ctx)
//    }

    var _pts : Polyline
    var _type : LinkType
    var _fromType : LinkEndPointType = .none
    var _toType : LinkEndPointType = .none
}
