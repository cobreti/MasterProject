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
    
    var diagramLayer : DiagramLayer? {
        get {
            return _layer
        }
        set (value) {
            _layer = value
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
    
    override func drawRect(dirtyRect: CGRect) {
        
        if let  layer = diagramLayer,
                portal = diagramPortal,
                document = diagramDocument,
                pinPt = pinPoint {

            var ctx : CGContext = UIGraphicsGetCurrentContext()
            
            let dd = DiagramDisplay(    targetRect: bounds,
                                        layer: layer,
                                        document: document,
                                        portal: portal,
                                        viewPinPt: pinPt )
            
            dd.display(ctx)
        }
    }
    
    var _portal : DiagramPortal?
    var _layer : DiagramLayer?
    var _document : Document?
    var _pinPoint : PinPoint?
}
