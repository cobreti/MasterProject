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
        
        view.addSubview(controller.view)
        controller.view.frame = CGRect(x: 25, y: 10, width: 100, height: 100)
        controller.resetView()
    }
 
    weak var _diagramViewsManager : DiagramViewsManager!
}

