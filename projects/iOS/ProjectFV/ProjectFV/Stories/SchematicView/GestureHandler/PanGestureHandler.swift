//
//  PanGestureHandler.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-31.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import Shapes

class PanGestureHandler : NSObject {
    
    init( view: DiagramView, portal: DiagramPortal ) {
        
        _view = view
        _portal = portal
        _startPt = CGPoint(x: 0,y: 0)
        _originalTranslation = Point(x: 0, y: 0)

        super.init()

        var panRecognizer = UIPanGestureRecognizer()
        panRecognizer.addTarget(self, action: "onPan:")
        _view.addGestureRecognizer(panRecognizer)
    }
    
    func onPan( sender : UIPanGestureRecognizer ) {
    
        switch sender.state {
            case UIGestureRecognizerState.Began:
                _startPt = sender.translationInView(_view)
                _originalTranslation = _portal.translation
                break
            case UIGestureRecognizerState.Changed:
                let pt = sender.translationInView(_view)
                var transform = Point(pt: _originalTranslation)
                transform.x += pt.x / _portal.scalingFactor
                transform.y += pt.y / _portal.scalingFactor
                _portal.translation = transform
                _view.setNeedsDisplay();
                break
            default:
                break
        }
    }
    

    var _view : DiagramView
    var _portal : DiagramPortal
    
    var _startPt : CGPoint
    var _originalTranslation : Point
}