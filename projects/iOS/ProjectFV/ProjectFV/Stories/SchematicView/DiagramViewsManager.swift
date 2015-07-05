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
    
    func activate(controller: DiagramViewController) {
     
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
 
    func deactivate(controller: DiagramViewController) {
        
        if _diagramViewControllers.count < 2 {
            return
        }
        
        if let ctrller = currentController where ctrller === controller {
            
            _diagramViewControllers.removeLast()
            _schematicViewController.deactivate(controller, newController: currentController!)
        }
    }
 
    var _diagramViewControllers : [DiagramViewController] = []
    var _schematicViewController : SchematicViewController
    var _delegate : DiagramViewsManagerDelegate!
}
