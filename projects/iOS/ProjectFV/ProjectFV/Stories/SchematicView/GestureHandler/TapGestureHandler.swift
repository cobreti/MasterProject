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
    
    override init(view: DiagramView, portal: DiagramPortal) {
        
        super.init(view: view, portal: portal)
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: "onTap:")
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func onTap( _ sender : UITapGestureRecognizer ) {
        
        if !enabled {
            return
        }
        
        switch sender.state {
            case UIGestureRecognizerState.began:
                _element = nil
            
            case UIGestureRecognizerState.ended:
                if let _ = view.diagram {
                    let ptInView = sender.location(in: view)
                    
                    let diagPt = portal.pointFromViewToPortal(Point(x: ptInView.x, y: ptInView.y))
                    
                    Application.instance().actionsBus.send( TapDiagramAction(pt: diagPt, sender: self))
                }
            default:
                break
        }
    }
    
    var _element : Element!
}
