//
// Created by Danny Thibaudeau on 15-08-16.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes
import UIKit

class DisplayGraph_GeneralizationEndPoint : DisplayGraph_EndPoint {

    override func draw(ctx: CGContext, portal: DiagramPortal) {

        let p1 = _p1
        let p2 = _p2
        var portalPt = portal.pointFromDiagramToPortal(p1)
        var portalEndPt1 = portal.pointFromDiagramToPortal(p1)
        var portalEndPt2 = portal.pointFromDiagramToPortal(p2)

        let axisSystem = AxisSystem(p1: portalEndPt1, p2: portalEndPt2)

        var p : Point = p1

        CGContextBeginPath(ctx)
        p = axisSystem.fromAxis(Point(x: 0, y: 0))
        CGContextMoveToPoint(ctx, p.x, p.y)

        p = axisSystem.fromAxis(Point(x: 15, y: 10))
        CGContextAddLineToPoint(ctx, p.x, p.y)

        p = axisSystem.fromAxis(Point(x: 15, y: -10))
        CGContextAddLineToPoint(ctx, p.x, p.y)

        CGContextClosePath(ctx)
        CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0)
        CGContextFillPath(ctx)

        CGContextBeginPath(ctx)
        p = axisSystem.fromAxis(Point(x: 0, y: 0))
        CGContextMoveToPoint(ctx, p.x, p.y)

        p = axisSystem.fromAxis(Point(x: 15, y: 10))
        CGContextAddLineToPoint(ctx, p.x, p.y)

        p = axisSystem.fromAxis(Point(x: 15, y: -10))
        CGContextAddLineToPoint(ctx, p.x, p.y)

        CGContextClosePath(ctx)
        CGContextSetRGBStrokeColor(ctx, 0.0, 0.0, 0.0, 1.0)
        CGContextStrokePath(ctx)
    }

}
