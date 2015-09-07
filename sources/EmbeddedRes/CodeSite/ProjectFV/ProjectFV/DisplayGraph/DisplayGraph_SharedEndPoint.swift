//
// Created by Danny Thibaudeau on 15-08-16.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes
import UIKit

class DisplayGraph_SharedEndPoint : DisplayGraph_EndPoint {

    override func draw(params: DisplayGraphDrawParams) {

        if params.drawingMode != .Normal {
            return
        }

//        var portalPt = portal.pointFromDiagramToPortal(p1)
        var portalEndPt1 = params.portal.pointFromDiagramToPortal(_p1)
        var portalEndPt2 = params.portal.pointFromDiagramToPortal(_p2)

        let axisSystem = AxisSystem(p1: portalEndPt1, p2: portalEndPt2)

        var p : Point = _p1

        CGContextBeginPath(params.context)
        p = axisSystem.fromAxis(Point(x: 0, y: 0))
        CGContextMoveToPoint(params.context, p.x, p.y)

        p = axisSystem.fromAxis(Point(x: 10, y: 7))
        CGContextAddLineToPoint(params.context, p.x, p.y)

        p = axisSystem.fromAxis(Point(x: 20, y: 0))
        CGContextAddLineToPoint(params.context, p.x, p.y)

        p = axisSystem.fromAxis(Point(x: 10, y: -7))
        CGContextAddLineToPoint(params.context, p.x, p.y)

        CGContextClosePath(params.context)
        CGContextSetRGBFillColor(params.context, 1.0, 1.0, 1.0, 1.0)
        CGContextFillPath(params.context)

        CGContextBeginPath(params.context)
        p = axisSystem.fromAxis(Point(x: 0, y: 0))
        CGContextMoveToPoint(params.context, p.x, p.y)

        p = axisSystem.fromAxis(Point(x: 10, y: 7))
        CGContextAddLineToPoint(params.context, p.x, p.y)

        p = axisSystem.fromAxis(Point(x: 20, y: 0))
        CGContextAddLineToPoint(params.context, p.x, p.y)

        p = axisSystem.fromAxis(Point(x: 10, y: -7))
        CGContextAddLineToPoint(params.context, p.x, p.y)

        CGContextClosePath(params.context)
        CGContextSetRGBStrokeColor(params.context, 0.0, 0.0, 0.0, 1.0)
        CGContextStrokePath(params.context)
    }

}
