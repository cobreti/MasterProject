//
//  ZoomGestureHandler.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-31.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import Shapes

class ZoomGestureHandler : NSObject {
    

    init( view: DiagramView, portal: DiagramPortal ) {
        
        _view = view
        _portal = portal
        _originalTranslation = Point(x: 0, y: 0)
        _ptInView = Point(x: 0, y: 0)

        super.init()

        var zoomRecognizer = UIPinchGestureRecognizer()
        zoomRecognizer.addTarget(self, action: "onZoom:")
        _view.addGestureRecognizer(zoomRecognizer)
    }
    
    func onZoom( sender : UIPinchGestureRecognizer ) {
        
        switch sender.state {
            case UIGestureRecognizerState.Began:
                sender.scale = CGFloat(_portal.zoom)
                let pt = sender.locationInView(_view)
                let pinPt = PinPoint(x: pt.x, y: pt.y)
                
                _ptInView = Point(x: pt.x, y: pt.y)
                _view.pinPoint = pinPt
            
                let diagPt = _portal.PointFromViewToPortal(pinPt)
                _portal.pinPoint = PinPoint(x: diagPt.x, y: diagPt.y)
            
            case UIGestureRecognizerState.Changed:
                _portal.zoom = sender.scale
                _portal.alignWithViewPinPoint(_view.pinPoint!)
                _view.setNeedsDisplay()
            default:
                break
        }
    }

    var _view : DiagramView
    var _portal : DiagramPortal
    var _originalTranslation : Point
    var _ptInView : Point
}
