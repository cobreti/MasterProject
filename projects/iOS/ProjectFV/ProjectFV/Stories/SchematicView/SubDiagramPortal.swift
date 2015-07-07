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
    
    var subDiagramController : DiagramViewController! {
        get {
            return _controller
        }
    }
    
    init(view: DiagramView, portal: DiagramPortal, parentController: SchematicViewController) {
        _view  = view
        _portal = portal
        _parentController = parentController
    }
    
    func reset() {
        
        if let ctrller = _controller {
            ctrller.view.removeFromSuperview()
        }

        detach()
    }
    
    func detach() {
        
        _element = nil
        _subDiagram = nil
        _controller = nil
    }
    
    func pickElm() {
        
        if let  diagram = _view.diagram,
                pinPt = _view.pinPoint {
                
            for (_, prim) in diagram.primitives {
                
                if let elm = prim as? Element {
                
                    let portalRect = _portal.rectFromDiagramToPortal(elm.box)

                    if portalRect.contains(pinPt) {
                        if let  model = _view.diagramDocument?.models.get(elm.modelId),
                                name = model.subDiagramName,
                                subDiagram = _view.diagramDocument?.diagrams.get(name) where !_parentController.diagramViewsManager.contains(name) {
                                
                            _element = elm
                            _subDiagram = subDiagram
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
        _subDiagram = nil
        _controller = nil
    }
        
    func updateSubDiagramArea() {
        
        if let  elm = _element {
                    
            let portalRect = _portal.rectFromDiagramToPortal(elm.box)
            
            if (portalRect.size.width > 400 || portalRect.size.height > 400) {
                
                if _controller == nil {
                    _controller = DiagramViewController(parentController: _parentController, diagram: _subDiagram)
                    _controller.view?.userInteractionEnabled = false
                    _controller.viewDrawingMode = .Thumbnail
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
    
    func enterSubDiagram() -> Bool {
        
        if let  elm = _element {
            
            let portalRect = _portal.rectFromDiagramToPortal(elm.box)
            
            return (portalRect.size.width > 800 || portalRect.size.height > 800)
        }

        return false
    }
    
    
    var _element : Element!
    var _controller : DiagramViewController!
    var _subDiagram : Diagram!
    var _parentController: SchematicViewController
    
    var _view : DiagramView
    var _portal : DiagramPortal
}

