//
//  DiagramViewsManager.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-04.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class DiagramViewsManager {
    
    var currentController : DiagramViewController! {
        get {
            return _diagramViewControllers.last
        }
    }
    
    var parentDiagramController : DiagramViewController! {
        get {
            if _diagramViewControllers.count < 2 {
                return nil
            }
            
            return _diagramViewControllers[_diagramViewControllers.count-2]
        }
    }
    
    init( schematicViewController: SchematicViewController, delegate: DiagramViewsManagerDelegate! = nil ) {
        _schematicViewController = schematicViewController
        _delegate = delegate
    }
    
    func onAction(_ action: Action) {

        switch action.id {

            case .HistoryDiagramSelected:
                if let hdsa = action as? HistoryDiagramSelectedAction {
                    onHistoryDiagramSelected(hdsa)
                }

            default:
                break
        }

        currentController?.onAction(action)
    }

    func onHistoryDiagramSelected(_ action: HistoryDiagramSelectedAction) {

        while let item = _diagramViewControllers.last, item !== action.diagramController {

            item.deactivate()
            _diagramViewControllers.removeLast()
        }

        if let item = _diagramViewControllers.last {
            item.activateInView(_schematicViewController._diagramArea)
            item.view.frame = _schematicViewController._diagramArea.bounds
            item.viewDrawingMode = .normal
            item.view.isUserInteractionEnabled = true
            item.diagramView.prepareView()
            item.updatePortalRect()
        }
    }
    
    func activate(_ controller: DiagramViewController) {
     
        var oldController : DiagramViewController! = nil
     
        if let ctrller = currentController {
            ctrller.deactivate()
            oldController = ctrller
        }
        
        _diagramViewControllers.append(controller)
        _schematicViewController.activate(controller, completionHandler: {() -> Void in
            self._delegate.onDiagramViewActivated(oldController, newDiagramView: controller)
        })
    }
 
    func deactivate(_ controller: DiagramViewController) {
        
        if _diagramViewControllers.count < 2 {
            return
        }
        
        if let ctrller = currentController, ctrller === controller {
            
            _diagramViewControllers.removeLast()
            _schematicViewController.deactivate(controller, newController: currentController!, completionHandler: {() -> Void in
                self._delegate.onDiagramViewDeactivated(controller)
            })
        }
    }
    
    func contains(_ diagramName : String) -> Bool {
        
        for c in _diagramViewControllers {
            if let  d = c.diagram, d.name == diagramName {
                return true
            }
        }
        
        return false
    }
 
    var _diagramViewControllers : [DiagramViewController] = []
    var _schematicViewController : SchematicViewController
    var _delegate : DiagramViewsManagerDelegate!
}
