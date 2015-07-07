//
//  DiagramsHistoryController.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-04.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class DiagramsHistoryController : UIViewController {
    
    
    var diagramViewsManager : DiagramViewsManager! {
        get {
            return _diagramViewsManager
        }
        set (value) {
            _diagramViewsManager = value
        }
    }

    func add(controller: DiagramViewController) {
        
        let yPos = _controllers.count * (100 + 10)
        
        
        _controllers.append(controller)
        view.addSubview(controller.view)
        controller.view.frame = CGRect(x: 25, y: yPos, width: 100, height: 100)
        controller.resetView()
        controller.viewDrawingMode = .Thumbnail
    }
    
    func remove(controller: DiagramViewController) {
        
        if let l = _controllers.last {
            _controllers.removeLast()
        }
    }
 
    weak var _diagramViewsManager : DiagramViewsManager!
    
    var _controllers : [DiagramViewController] = []
}

