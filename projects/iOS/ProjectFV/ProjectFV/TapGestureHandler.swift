//
//  TapGestureHandler.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-31.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import Shapes

class TapGestureHandler : NSObject {
    
    init(view: DiagramView, portal: DiagramPortal) {
        
        _view = view
        _portal = portal
        
        super.init()
        
        var tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: "onTap:")
        _view.addGestureRecognizer(tapRecognizer)
    }
    
    func onTap( sender : UITapGestureRecognizer ) {
        
        switch sender.state {
            case UIGestureRecognizerState.Ended:
                let ptInView = sender.locationInView(_view)
                _view.pinPoint = PinPoint(x: Double(ptInView.x), y: Double(ptInView.y))
                
                let diagPt = _portal.PointFromViewToPortal(_view.pinPoint!)
                _portal.pinPoint = PinPoint(x: diagPt.x, y: diagPt.y)
                
                _view.setNeedsDisplay()
            default:
                break
        }
    }
    
    var _view : DiagramView
    var _portal : DiagramPortal
}