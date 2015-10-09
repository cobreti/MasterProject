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

    var subDiagramIcon: UIImage! {
        get {
            return _subDiagramIcon
        }
        set (value) {
            _subDiagramIcon = value
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

        if let _ = _fileIcon {
            drawFileIcon(cgRC)
        }

        if let _ = _subDiagramIcon {
            drawSubDiagramIcon(cgRC)
        }

        if let _ = _name where params.drawingMode == .Normal {
            drawName(cgRC, context: params.context)
        }
    }

    func drawFileIcon(rect: CGRect) {

        var imgWidth = max(rect.width / 3 - 2, 0)
        var imgHeight = rect.height / 3

        imgWidth = min(imgWidth, _fileIcon.size.width)
        imgHeight = min(imgHeight, _fileIcon.size.height)

        let imgSize = min(imgWidth, imgHeight)

        let rcImg = CGRect( x: rect.minX+2, y: rect.minY+2, width: imgSize, height: imgSize )

        _fileIcon.drawInRect(rcImg)
    }

    func drawSubDiagramIcon(rect: CGRect) {

        var imgWidth = max(rect.width / 3 - 2, 0)
        var imgHeight = rect.height / 3

        imgWidth = min(imgWidth, _subDiagramIcon.size.width)
        imgHeight = min(imgHeight, _subDiagramIcon.size.height)

        let imgSize = min(imgWidth, imgHeight)

        let rcImg = CGRect( x: rect.maxX-imgWidth-2, y: rect.minY+2, width: imgSize, height: imgSize )

        _subDiagramIcon.drawInRect(rcImg)
    }

    func drawName(rect: CGRect, context: CGContext) {

        let parStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        let strContext : NSStringDrawingContext = NSStringDrawingContext()
        let strOptions : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rcText = rect
        var font : UIFont = UIFont(name: "helvetica", size: 12.0)!
        
        parStyle.alignment = NSTextAlignment.Center
        parStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping

        var rcStr = name.boundingRectWithSize(
                                rcText.size,
                                options: strOptions,
                                attributes: [
                                                NSParagraphStyleAttributeName: parStyle,
                                                NSFontAttributeName: font
                                            ],
                                context: strContext )

        var rc : CGRect = rcText

        if rc.width - rcStr.width < 20 || rc.height - rcStr.height < 20 {
            font = UIFont(name: "helvetica", size: 10.0)!;

            rcStr = name.boundingRectWithSize(
                                rcText.size,
                                options: strOptions,
                                attributes: [
                                    NSParagraphStyleAttributeName: parStyle,
                                    NSFontAttributeName: font
                                ],
                                context: strContext )
        }

        CGContextSaveGState(context)
        CGContextClipToRect(context, rc)

        CGContextSetFontSize(context, 8.0)
        
        rc.insetInPlace(dx: 0, dy: (rc.height - rcStr.size.height)/2)

        name.drawWithRect(  rc,
                            options: strOptions,
                            attributes: [
                                NSParagraphStyleAttributeName: parStyle,
                                NSFontAttributeName: font
                            ],
                            context: strContext )

        CGContextRestoreGState(context)
    }

    var _rect : Rect
    var _name : String!
    var _fileIcon : UIImage!
    var _subDiagramIcon : UIImage!
}
