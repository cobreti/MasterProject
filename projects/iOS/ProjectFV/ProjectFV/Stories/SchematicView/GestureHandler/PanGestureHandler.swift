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

class PanGestureHandler : BaseGestureHandler {
    
    override init( view: DiagramView, portal: DiagramPortal, delegate: GestureHandlerDelegate! ) {
        
        _startPt = CGPoint(x: 0,y: 0)
        _originalTranslation = Point(x: 0, y: 0)

        super.init(view: view, portal: portal, delegate: delegate)

        var panRecognizer = UIPanGestureRecognizer()
        panRecognizer.addTarget(self, action: "onPan:")
        self.view.addGestureRecognizer(panRecognizer)
    }
    
    func onPan( sender : UIPanGestureRecognizer ) {
    
        if !enabled {
            return
        }
    
        switch sender.state {
            case UIGestureRecognizerState.Began:
                _startPt = sender.translationInView(self.view)
                _originalTranslation = self.portal.translation
                delegate?.onGestureStarted()
                break
            case UIGestureRecognizerState.Changed:
                let pt = sender.translationInView(self.view)
                var transform = Point(pt: _originalTranslation)
                transform.x += pt.x / self.portal.scalingFactor
                transform.y += pt.y / self.portal.scalingFactor
                self.portal.translation = transform
                self.view.setNeedsDisplay()
                delegate?.onGestureChanged()
                break
            case UIGestureRecognizerState.Ended:
                delegate?.onGestureEnded()
            default:
                break
        }
    }
    
    
    var _startPt : CGPoint
    var _originalTranslation : Point
}