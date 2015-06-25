//
//  SubDiagramHandler.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-24.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements

class SubDiagramHandler {
    
    init(view: DiagramView, portal: DiagramPortal) {
        _view  = view
        _portal = portal
    }
    
    func checkForSubDiagramDisplay() {
        
        if let layer = _view.diagramLayer {
            for (id, prim) in layer.primitives {
                
                if let elm = prim as? Element {
                    checkForSubDiagramDisplayInElement(elm)
                }
            }
        }
    }
    
    func checkForSubDiagramDisplayInElement(elm : Element) {
        
        var portalRect = _portal.rectFromDiagramToPortal(elm.box)
        
        if let  model = _view.diagramDocument?.models.get(elm.modelId),
                name = model.subDiagramName,
                pinPt = _view.pinPoint,
                subLayer = _view.diagramDocument?.layers.get(name) {
                
            if (portalRect.size.width > 400 || portalRect.size.height > 400) && portalRect.contains(pinPt) {
                
                if _element !== elm {
                    
                    _element = elm
                    _controller = DiagramViewController(nibName: "DiagramView", bundle: nil)
                    _controller.diagramLayer = subLayer
//                    _controller.gestureEnabled = false
                    
                    if let v = _controller.view {
                        
                        _view.addSubview(v)
                        v.frame = portalRect.toCGRect()
//                        _view.bringSubviewToFront(v)
                        v.userInteractionEnabled = false
                        v.setNeedsDisplay()
                    }
                }
                else {
                    
                    if let v = _controller.view {
                        v.frame = portalRect.toCGRect()
                        _controller.updatePortalRect()
                        v.setNeedsDisplay()
                    }
                }
            }
            else {
            
                if let  subElm = _element,
                        ctrller = _controller {
                        
                    ctrller.view.removeFromSuperview()
                    _controller = nil
                    _element = nil
                }
            }
        }
    }
    
    var _element : Element!
    var _controller : DiagramViewController!
    var _view : DiagramView
    var _portal : DiagramPortal
}