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

class TapGestureHandler : BaseGestureHandler {
    
    var pickedElement : Element! {
        get {
            return _element
        }
    }
    
    override init(view: DiagramView, portal: DiagramPortal, delegate: GestureHandlerDelegate!) {
        
        super.init(view: view, portal: portal, delegate: delegate)
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: "onTap:")
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func onTap( sender : UITapGestureRecognizer ) {
        
        if !enabled {
            return
        }
        
        switch sender.state {
            case UIGestureRecognizerState.Began:
                _element = nil
            
            case UIGestureRecognizerState.Ended:
                if let diagram = view.diagram {
                    let ptInView = sender.locationInView(view)
                    
                    let diagPt = portal.pointFromViewToPortal(Point(x: ptInView.x, y: ptInView.y))
                    
                    Application.instance().actionsBus.send( TapDiagramAction(pt: diagPt, sender: self))

//                    let primitives = diagram.primitivesFromPt(diagPt)
//                    
//                    if primitives.isEmpty {
//                        diagram.selection.clear()
//                    }
//                    else {
//                        for item in primitives {
//                            
//                            if let elm = item as? Element {
//                                _element = elm
//                            }
//                            
//                       }
//                    }
//                    
//                    delegate?.onGestureEnded(self)

                }
            default:
                break
        }
    }
    
    var _element : Element!
}