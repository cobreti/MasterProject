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

    override func draw(_ params: DisplayGraphDrawParams) {

        if params.drawingMode != .normal {
            return
        }

        let parStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        let strSize = _text.size(attributes: [
                                                      NSParagraphStyleAttributeName: parStyle
                                              ])
        let portalPt = params.portal.pointFromDiagramToPortal( Point(x: _pos.x+strSize.width/2, y: _pos.y+strSize.height/2) )
        let rc : CGRect = CGRect(x: portalPt.x, y: portalPt.y, width: strSize.width, height: strSize.height)

        parStyle.alignment = NSTextAlignment.center

        _text.draw(in: rc, withAttributes: [
                NSParagraphStyleAttributeName: parStyle
        ])
    }


    var _pos : Point
    var _text : String
}
