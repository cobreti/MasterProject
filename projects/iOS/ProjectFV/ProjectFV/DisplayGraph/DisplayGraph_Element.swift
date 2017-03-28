//
// Created by Danny Thibaudeau on 15-08-15.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import Shapes

class DisplayGraph_Element : DisplayGraphItem {

    enum State {
        case normal
        case selected
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

    var originIcon: UIImage! {
        get {
            return _originIcon
        }
        set (value) {
            _originIcon = value
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

    override func draw(_ params: DisplayGraphDrawParams) {

        let portalRect = params.portal.rectFromDiagramToPortal(_rect)
        let cgRC = CGRect(  x: portalRect.pos.x,
                            y: portalRect.pos.y,
                            width: portalRect.size.width,
                            height: portalRect.size.height)



        if _state == .selected {

            let fillColor = UIColor(red: 241.0/255.0, green: 244.0/255.0, blue: 238.0/255.0, alpha: 1.0)
            params.context.setFillColor(fillColor.cgColor)
            params.context.fill(cgRC)

            let rc = cgRC.insetBy(dx: -3, dy: -3)
            params.context.setLineWidth(3.0)
            params.context.stroke(rc)
            params.context.setLineWidth(1.0)
        }
        else {

            params.context.stroke(cgRC)
        }

        if let _ = _fileIcon {
            drawFileIcon(cgRC)
        }

        if let _ = _subDiagramIcon {
            drawSubDiagramIcon(cgRC)
        }

        if let _ = _originIcon {
            drawOriginIcon(cgRC)
        }

        if let _ = _lastSelectedIcon {
            drawLastSelectedIcon(cgRC)
        }

//        if let _ = _name where params.drawingMode == .Normal {
            drawName(cgRC, context: params.context)
//        }
    }

    func drawOriginIcon(_ rect: CGRect) {

        var imgWidth = max(rect.width / 3 - 2, 0)
        var imgHeight = rect.height / 3

        imgWidth = min(imgWidth, _originIcon.size.width)
        imgHeight = min(imgHeight, _originIcon.size.height)

        let imgSize = min(imgWidth, imgHeight)

        let rcImg = CGRect( x: rect.minX - imgSize, y: rect.minY - imgSize, width: imgSize, height: imgSize )

        _originIcon.draw(in: rcImg)
    }

    func drawLastSelectedIcon(_ rect: CGRect) {

        var imgWidth = max(rect.width / 3 - 2, 0)
        var imgHeight = rect.height / 3

        imgWidth = min(imgWidth, _lastSelectedIcon.size.width)
        imgHeight = min(imgHeight, _lastSelectedIcon.size.height)

        let imgSize = min(imgWidth, imgHeight)

        let rcImg = CGRect( x: rect.maxX, y: rect.maxY, width: imgSize, height: imgSize )

        _lastSelectedIcon.draw(in: rcImg)
    }

    func drawFileIcon(_ rect: CGRect) {

        var imgWidth = max(rect.width / 3 - 2, 0)
        var imgHeight = rect.height / 3

        imgWidth = min(imgWidth, _fileIcon.size.width)
        imgHeight = min(imgHeight, _fileIcon.size.height)

        let imgSize = min(imgWidth, imgHeight)

        let rcImg = CGRect( x: rect.minX+2, y: rect.minY+2, width: imgSize, height: imgSize )

        _fileIcon.draw(in: rcImg)
    }

    func drawSubDiagramIcon(_ rect: CGRect) {

        var imgWidth = max(rect.width / 3 - 2, 0)
        var imgHeight = rect.height / 3

        imgWidth = min(imgWidth, _subDiagramIcon.size.width)
        imgHeight = min(imgHeight, _subDiagramIcon.size.height)

        let imgSize = min(imgWidth, imgHeight)

        if let _ = _fileIcon {
            let rcImg = CGRect(x: rect.maxX - imgWidth - 2, y: rect.minY + 2, width: imgSize, height: imgSize)

            _subDiagramIcon.draw(in: rcImg)
        }
        else {
            let rcImg = CGRect(x: rect.minX + 2, y: rect.minY + 2, width: imgSize, height: imgSize)

            _subDiagramIcon.draw(in: rcImg)
        }
    }

    func drawName(_ rect: CGRect, context: CGContext) {

        let textArea = rect.insetBy(dx: 5, dy: 5)
        let parStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        let strContext : NSStringDrawingContext = NSStringDrawingContext()
        let strOptions : NSStringDrawingOptions = NSStringDrawingOptions.usesLineFragmentOrigin
        let rcText = textArea
        var font : UIFont = UIFont(name: "helvetica", size: 12.0)!
        
        parStyle.alignment = NSTextAlignment.center
        parStyle.lineBreakMode = NSLineBreakMode.byWordWrapping

        let strSize = name.size(
            attributes: [
                    NSParagraphStyleAttributeName: parStyle,
                    NSFontAttributeName: font
            ]
        )

        if strSize.width > textArea.size.width {

            let ratio = strSize.height / strSize.width

            UIGraphicsBeginImageContextWithOptions(strSize, false, UIScreen.main.scale)

            name.draw(with: CGRect(origin: CGPoint(x: 0, y: 0), size: strSize),
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

            textImg?.draw(in: rc)
        }
        else {

            var rcStr = name.boundingRect(
            with: textArea.size,
            options: strOptions,
            attributes: [
                    NSParagraphStyleAttributeName: parStyle,
                    NSFontAttributeName: font
            ],
            context: strContext)

            var rc: CGRect = rcText

            if rc.width - rcStr.width < 20 || rc.height - rcStr.height < 20 {
                font = UIFont(name: "helvetica", size: 10.0)!;

                rcStr = name.boundingRect(
                    with: rcText.size,
                    options: strOptions,
                    attributes: [
                            NSParagraphStyleAttributeName: parStyle,
                            NSFontAttributeName: font
                    ],
                    context: strContext)
            }

            context.saveGState()
            context.clip(to: rc)

            context.setFontSize(8.0)

            rc = rc.insetBy(dx: 0, dy: (rc.height - rcStr.size.height) / 2)

            name.draw(with: rc,
                              options: strOptions,
                              attributes: [
                                      NSParagraphStyleAttributeName: parStyle,
                                      NSFontAttributeName: font
                              ],
                              context: strContext)

            context.restoreGState()
        }
    }

    var _rect : Rect
    var _name : String!
    var _fileIcon : UIImage!
    var _subDiagramIcon : UIImage!
    var _originIcon : UIImage!
    var _lastSelectedIcon : UIImage!
    var _state : State = .normal
}
