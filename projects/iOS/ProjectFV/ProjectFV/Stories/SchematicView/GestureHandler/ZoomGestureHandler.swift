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

class ZoomGestureHandler : BaseGestureHandler {
    

    override init( view: DiagramView, portal: DiagramPortal, delegate: GestureHandlerDelegate! ) {
        
        _originalTranslation = Point(x: 0, y: 0)
        _ptInView = Point(x: 0, y: 0)
//        _subDiagramHandler = SubDiagramHandler(view: view, portal: portal)

        super.init(view: view, portal: portal, delegate: delegate)

        var zoomRecognizer = UIPinchGestureRecognizer()
        zoomRecognizer.addTarget(self, action: "onZoom:")
        view.addGestureRecognizer(zoomRecognizer)
    }
    
    func onZoom( sender : UIPinchGestureRecognizer ) {
    
        if !enabled {
            return
        }
        
        switch sender.state {
            case UIGestureRecognizerState.Began:
                sender.scale = CGFloat(portal.zoom)
                let pt = sender.locationInView(view)
                let pinPt = PinPoint(x: pt.x, y: pt.y)
                
                _ptInView = Point(x: pt.x, y: pt.y)
                view.pinPoint = pinPt
            
                let diagPt = portal.pointFromViewToPortal(pinPt)
                portal.pinPoint = PinPoint(x: diagPt.x, y: diagPt.y)
            
                delegate?.onGestureStarted()
            
            case UIGestureRecognizerState.Changed:
                portal.zoom = sender.scale
                portal.alignWithViewPinPoint(view.pinPoint!)
//                _subDiagramHandler.checkForSubDiagramDisplay()
                view.setNeedsDisplay()
            
                delegate?.onGestureChanged()
            
            case UIGestureRecognizerState.Ended:
                delegate?.onGestureEnded()
//                _subDiagramHandler.checkForSubDiagramDisplay()
//                view.setNeedsDisplay()
            
            default:
                break
        }
    }

    var _originalTranslation : Point
    var _ptInView : Point
//    var _subDiagramHandler : SubDiagramHandler
}

