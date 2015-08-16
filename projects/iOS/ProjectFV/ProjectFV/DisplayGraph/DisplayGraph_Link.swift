//
// Created by Danny Thibaudeau on 15-08-15.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import Shapes
import DiagramElements

class DisplayGraph_Link : DisplayGraphItem {

    init(pts: Polyline, type: LinkType) {

        _pts = pts
        _type = type
    }

    override func draw(ctx: CGContext, portal: DiagramPortal) {

        let count = _pts.count

        if count > 1 {

            CGContextBeginPath(ctx)

            var pt = _pts.get(0)
            var portalPt = portal.pointFromDiagramToPortal(pt)
            CGContextMoveToPoint(ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))

            for var idx = 1; idx < count; idx++ {
                pt = _pts.get(idx)
                portalPt = portal.pointFromDiagramToPortal(pt)
                CGContextAddLineToPoint(ctx, CGFloat(portalPt.x), CGFloat(portalPt.y))
            }

            CGContextDrawPath(ctx, kCGPathStroke)
        }
    }


    var _pts : Polyline
    var _type : LinkType
}
