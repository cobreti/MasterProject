//
//  DiagramView.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-15.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements
import Shapes
import UIKit

class DiagramView : UIView {


    var diagramPortal : DiagramPortal? {
        get {
            return _portal
        }
        set (value) {
            _portal = value
        }
    }
    
    var diagram : Diagram? {
        get {
            return _diagram
        }
        set (value) {
            _diagram = value
        }
    }
    
    var diagramDocument : Document? {
        get {
            return _document
        }
        set (value) {
            _document = value
        }
    }
    
    var pinPoint : PinPoint? {
        get {
            return _pinPoint
        }
        set (value) {
            _pinPoint = value
        }
    }
    
    var drawingMode : ViewDrawingMode {
        get {
            return _drawingMode
        }
        set (value) {
            _drawingMode = value
        }
    }
    
    
    override func drawRect(dirtyRect: CGRect) {
        
        super.drawRect(dirtyRect)
        
        if let  diag = diagram,
                portal = diagramPortal,
                document = diagramDocument,
                pinPt = pinPoint {

            var ctx : CGContext = UIGraphicsGetCurrentContext()
            
            let dd = DiagramDisplay(    targetRect: bounds,
                                        diagram: diag,
                                        document: document,
                                        portal: portal,
                                        viewPinPt: pinPt )
            dd.viewDrawingMode = _drawingMode
            
            dd.display(ctx)
        }
    }
    
    var _portal : DiagramPortal?
    var _diagram : Diagram?
    var _document : Document?
    var _pinPoint : PinPoint?
    var _drawingMode : ViewDrawingMode = .Normal
}

