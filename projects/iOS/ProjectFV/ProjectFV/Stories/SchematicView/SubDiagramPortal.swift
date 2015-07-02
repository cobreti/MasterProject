//
//  SubDiagramHandler.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-24.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements
import UIKit

class SubDiagramPortal {
    
    init(view: DiagramView, portal: DiagramPortal, parentController: SchematicViewController) {
        _view  = view
        _portal = portal
        _parentController = parentController
    }
    
    func reset() {
        
        if let ctrller = _controller {
            ctrller.view.removeFromSuperview()
        }
        
        _element = nil
        _subLayer = nil
        _controller = nil
    }
    
    func pickElm() {
        
        if let  layer = _view.diagramLayer,
                pinPt = _view.pinPoint {
                
            for (_, prim) in layer.primitives {
                
                if let elm = prim as? Element {
                
                    let portalRect = _portal.rectFromDiagramToPortal(elm.box)

                    if portalRect.contains(pinPt) {
                        if let  model = _view.diagramDocument?.models.get(elm.modelId),
                                name = model.subDiagramName,
                                subLayer = _view.diagramDocument?.layers.get(name) {
                                
                            _element = elm
                            _subLayer = subLayer
                            return
                        }
                    }
                }
            }
        }
        
        if let ctrller = _controller {
                
            ctrller.view.removeFromSuperview()
        }
        
        _element = nil
        _subLayer = nil
        _controller = nil
    }
        
    func updateSubDiagramArea() {
        
        if let  elm = _element {
                    
            let portalRect = _portal.rectFromDiagramToPortal(elm.box)
            
            if (portalRect.size.width > 400 || portalRect.size.height > 400) {
                
                if _controller == nil {
                    _controller = DiagramViewController(parentController: _parentController)
                    _controller.diagramLayer = _subLayer
                    _controller.view?.userInteractionEnabled = false
                    _view.addSubview(_controller.view)
                }

                if let v = _controller.view {
                    v.frame = portalRect.toCGRect()
                    _controller.updatePortalRect()
                }
            }
            else {
                
                if let ctrller = _controller {
                    ctrller.view.removeFromSuperview()
                    _controller = nil
                }
            }
            
        }
        
    }
    
    func onGestureEnded() {
        
        if let  elm = _element {
            
            let portalRect = _portal.rectFromDiagramToPortal(elm.box)
            
            if (portalRect.size.width > 800 || portalRect.size.height > 800) {
                
                _parentController.pushController(_controller)
            }
        }
    }
    
    
    var _element : Element!
    var _controller : DiagramViewController!
    var _subLayer : DiagramLayer!
    var _parentController: SchematicViewController
    
    var _view : DiagramView
    var _portal : DiagramPortal
}