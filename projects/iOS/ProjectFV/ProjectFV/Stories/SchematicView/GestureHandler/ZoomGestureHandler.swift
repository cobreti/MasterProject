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
    

    override init( view: DiagramView, portal: DiagramPortal) {
        
        _originalTranslation = Point(x: 0, y: 0)
        _ptInView = Point(x: 0, y: 0)

        super.init(view: view, portal: portal)

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
            
                Application.instance().actionsBus.send( ZoomDiagramAction(scale: sender.scale, velocity: sender.velocity, state: .Began, sender: self) )
            
            case UIGestureRecognizerState.Changed:
                portal.zoom = sender.scale
                portal.alignWithViewPinPoint(view.pinPoint!)

                Application.instance().actionsBus.send( ZoomDiagramAction(scale: sender.scale, velocity: sender.velocity, state: .Changed, sender: self) )

            case UIGestureRecognizerState.Ended:
                Application.instance().actionsBus.send( ZoomDiagramAction(scale: sender.scale, velocity: sender.velocity, state: .Ended, sender: self) )

            default:
                break
        }
    }

    var _originalTranslation : Point
    var _ptInView : Point
}

