//
// Created by Danny Thibaudeau on 15-08-15.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import Shapes

class DisplayGraph_Element : DisplayGraphItem {

    var fileIcon: UIImage! {
        get {
            return _fileIcon
        }
        set (value) {
            _fileIcon = value
        }
    }

    var name: String! {
        get {
            return _name
        }
        set (value) {
            _name = value
        }
    }

    init(rect: Rect) {
        _rect = rect
    }

    override func draw(params: DisplayGraphDrawParams) {

        let portalRect = params.portal.rectFromDiagramToPortal(_rect)
        let cgRC = CGRect(  x: portalRect.pos.x,
                            y: portalRect.pos.y,
                            width: portalRect.size.width,
                            height: portalRect.size.height)

        CGContextStrokeRect(params.context, cgRC)

        if let fileIcon = _fileIcon {
            drawFileIcon(cgRC)
        }

        if let name = _name where params.drawingMode == .Normal {
            drawName(cgRC)
        }
    }

    func drawFileIcon(rect: CGRect) {

        var imgWidth = max(rect.width / 3 - 2, 0)
        var imgHeight = rect.height / 3

        imgWidth = min(imgWidth, _fileIcon.size.width)
        imgHeight = min(imgHeight, _fileIcon.size.height)

        let imgSize = min(imgWidth, imgHeight)

        let rcImg = CGRect( x: rect.maxX-imgWidth-2, y: rect.minY+2, width: imgSize, height: imgSize )

        _fileIcon.drawInRect(rcImg)
    }

    func drawName(rect: CGRect) {

        var parStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        var strSize = name.sizeWithAttributes([
                                                      NSParagraphStyleAttributeName: parStyle
                                              ])
        var rc : CGRect = rect

        parStyle.alignment = NSTextAlignment.Center

        rc.inset(dx: 0, dy: (rc.height - strSize.height)/2)

        name.drawInRect(rc, withAttributes: [
                NSParagraphStyleAttributeName: parStyle
        ])
    }

    var _rect : Rect
    var _name : String!
    var _fileIcon : UIImage!
}
