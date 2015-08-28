//
// Created by Danny Thibaudeau on 15-08-27.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import Shapes
import DiagramElements

class DisplayGraph_Label : DisplayGraphItem {

    init(pos: Point, text: String) {

        _pos = pos
        _text = text
    }

    override func draw(params: DisplayGraphDrawParams) {

        if params.drawingMode != .Normal {
            return
        }

        var parStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        var portalPt = params.portal.pointFromDiagramToPortal(_pos)
        var strSize = _text.sizeWithAttributes([
                                                      NSParagraphStyleAttributeName: parStyle
                                              ])
        var rc : CGRect = CGRect(x: portalPt.x, y: portalPt.y, width: strSize.width, height: strSize.height)

        parStyle.alignment = NSTextAlignment.Center

        _text.drawInRect(rc, withAttributes: [
                NSParagraphStyleAttributeName: parStyle
        ])
    }


    var _pos : Point
    var _text : String
}
