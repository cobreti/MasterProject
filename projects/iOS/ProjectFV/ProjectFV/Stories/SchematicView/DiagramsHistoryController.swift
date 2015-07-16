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
        
        let yPos = _historyControllers.count * (100 + 10)

        let ctrller = DiagramHistoryThumbnailViewController(diagramController: controller)
        view.addSubview(ctrller.view)
        ctrller.view.frame = CGRect(x: 25, y: yPos, width: 100, height: 100)

        _historyControllers.append(ctrller)
    }
    
    func remove(controller: DiagramViewController) {
        
        if let l = _historyControllers.last {
            _historyControllers.removeLast()
            l.view.removeFromSuperview()
        }
    }

    func onAction(action: Action) {

        switch action.id {

            case .HistoryDiagramSelected:
                if let hdsa = action as? HistoryDiagramSelectedAction {
                    onHistoryDiagramSelected(hdsa)
                }

            default:
                break
        }
    }

    func onHistoryDiagramSelected(action: HistoryDiagramSelectedAction) {

        while let item = _historyControllers.last where item.diagramController !== action.diagramController {
            _historyControllers.removeLast()
            item.view.removeFromSuperview()
        }

        if let item = _historyControllers.last {
            _historyControllers.removeLast()
            item.view.removeFromSuperview()
        }

    }
 
    weak var _diagramViewsManager : DiagramViewsManager!
    
    var _historyControllers : [DiagramHistoryThumbnailViewController] = []
}

