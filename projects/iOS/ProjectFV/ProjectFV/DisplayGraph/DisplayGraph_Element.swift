//
// Created by Danny Thibaudeau on 15-08-15.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import Shapes

class DisplayGraph_Element : DisplayGraphItem {

    enum State {
        case Normal
        case Selected
    }

    var state: State {
        get {
            return _state
        }
        set (value) {
            _state = value
        }
    }

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



        if _state == .Selected {

            let fillColor = UIColor(red: 241.0/255.0, green: 244.0/255.0, blue: 238.0/255.0, alpha: 1.0)
            CGContextSetFillColorWithColor(params.context, fillColor.CGColor)
            CGContextFillRect(params.context, cgRC)

            let rc = CGRectInset(cgRC, -3, -3)
            CGContextSetLineWidth(params.context, 3.0)
            CGContextStrokeRect(params.context, rc)
            CGContextSetLineWidth(params.context, 1.0)
        }
        else {

            CGContextStrokeRect(params.context, cgRC)
        }

        if let _ = _fileIcon {
            drawFileIcon(cgRC)
        }

        if let _ = _subDiagramIcon {
            drawSubDiagramIcon(cgRC)
        }

//        if let _ = _name where params.drawingMode == .Normal {
            drawName(cgRC, context: params.context)
//        }
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

        if let _ = _fileIcon {
            let rcImg = CGRect(x: rect.maxX - imgWidth - 2, y: rect.minY + 2, width: imgSize, height: imgSize)

            _subDiagramIcon.drawInRect(rcImg)
        }
        else {
            let rcImg = CGRect(x: rect.minX + 2, y: rect.minY + 2, width: imgSize, height: imgSize)

            _subDiagramIcon.drawInRect(rcImg)
        }
    }

    func drawName(rect: CGRect, context: CGContext) {

        let textArea = CGRectInset(rect, 5, 5)
        let parStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        let strContext : NSStringDrawingContext = NSStringDrawingContext()
        let strOptions : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rcText = textArea
        var font : UIFont = UIFont(name: "helvetica", size: 12.0)!
        
        parStyle.alignment = NSTextAlignment.Center
        parStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping

        let strSize = name.sizeWithAttributes(
            [
                    NSParagraphStyleAttributeName: parStyle,
                    NSFontAttributeName: font
            ]
        )

        if strSize.width > textArea.size.width {

            let ratio = strSize.height / strSize.width

            UIGraphicsBeginImageContextWithOptions(strSize, false, UIScreen.mainScreen().scale)

            name.drawWithRect(CGRect(origin: CGPoint(x: 0, y: 0), size: strSize),
                              options: strOptions,
                              attributes: [
                                      NSParagraphStyleAttributeName: parStyle,
                                      NSFontAttributeName: font
                              ],
                              context: strContext)

            let textImg = UIGraphicsGetImageFromCurrentImageContext()

            UIGraphicsEndImageContext()

            let height = ratio*textArea.width;
            let y = textArea.origin.y + (textArea.size.height - height)/2
            let rc = CGRect(    origin: CGPoint(x: textArea.origin.x, y: y),
                                size: CGSize(width: textArea.width, height: ratio * textArea.width))

            textImg.drawInRect(rc)
        }
        else {

            var rcStr = name.boundingRectWithSize(
            textArea.size,
            options: strOptions,
            attributes: [
                    NSParagraphStyleAttributeName: parStyle,
                    NSFontAttributeName: font
            ],
            context: strContext)

            var rc: CGRect = rcText

            if rc.width - rcStr.width < 20 || rc.height - rcStr.height < 20 {
                font = UIFont(name: "helvetica", size: 10.0)!;

                rcStr = name.boundingRectWithSize(
                    rcText.size,
                    options: strOptions,
                    attributes: [
                            NSParagraphStyleAttributeName: parStyle,
                            NSFontAttributeName: font
                    ],
                    context: strContext)
            }

            CGContextSaveGState(context)
            CGContextClipToRect(context, rc)

            CGContextSetFontSize(context, 8.0)

            rc.insetInPlace(dx: 0, dy: (rc.height - rcStr.size.height) / 2)

            name.drawWithRect(rc,
                              options: strOptions,
                              attributes: [
                                      NSParagraphStyleAttributeName: parStyle,
                                      NSFontAttributeName: font
                              ],
                              context: strContext)

            CGContextRestoreGState(context)
        }
    }

    var _rect : Rect
    var _name : String!
    var _fileIcon : UIImage!
    var _subDiagramIcon : UIImage!
    var _state : State = .Normal
}
