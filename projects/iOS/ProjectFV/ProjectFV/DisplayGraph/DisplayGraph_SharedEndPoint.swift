//
// Created by Danny Thibaudeau on 15-08-16.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes
import UIKit

class DisplayGraph_SharedEndPoint : DisplayGraph_EndPoint {

    override func draw(_ params: DisplayGraphDrawParams) {

        if params.drawingMode != .normal {
            return
        }

//        var portalPt = portal.pointFromDiagramToPortal(p1)
        let portalEndPt1 = params.portal.pointFromDiagramToPortal(_p1)
        let portalEndPt2 = params.portal.pointFromDiagramToPortal(_p2)

        let axisSystem = AxisSystem(p1: portalEndPt1, p2: portalEndPt2)

        var p : Point = _p1

        params.context.beginPath()
        p = axisSystem.fromAxis(Point(x: 0, y: 0))
        params.context.move(to: CGPoint(x: p.x, y: p.y))

        p = axisSystem.fromAxis(Point(x: 10, y: 7))
        params.context.addLine(to: CGPoint(x: p.x, y: p.y))

        p = axisSystem.fromAxis(Point(x: 20, y: 0))
        params.context.addLine(to: CGPoint(x: p.x, y: p.y))

        p = axisSystem.fromAxis(Point(x: 10, y: -7))
        params.context.addLine(to: CGPoint(x: p.x, y: p.y))

        params.context.closePath()
        params.context.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        params.context.fillPath()

        params.context.beginPath()
        p = axisSystem.fromAxis(Point(x: 0, y: 0))
        params.context.move(to: CGPoint(x: p.x, y: p.y))

        p = axisSystem.fromAxis(Point(x: 10, y: 7))
        params.context.addLine(to: CGPoint(x: p.x, y: p.y))

        p = axisSystem.fromAxis(Point(x: 20, y: 0))
        params.context.addLine(to: CGPoint(x: p.x, y: p.y))

        p = axisSystem.fromAxis(Point(x: 10, y: -7))
        params.context.addLine(to: CGPoint(x: p.x, y: p.y))

        params.context.closePath()
        params.context.setStrokeColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        params.context.strokePath()
    }

}
