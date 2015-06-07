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
import DiagramElements

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
                if let layer = _view.diagramLayer {
                    let ptInView = sender.locationInView(_view)
                    
                    let diagPt = _portal.pointFromViewToPortal(Point(x: ptInView.x, y: ptInView.y))

                    let primitives = layer.primitivesFromPt(diagPt)
                    
                    if primitives.isEmpty {
                        layer.selection.clear()
                    }
                    else {
                        for item in primitives {
                            layer.selection.add(item)
                        }
                    }

                    _view.setNeedsDisplay()
                }
            default:
                break
        }
    }
    
    var _view : DiagramView
    var _portal : DiagramPortal
}