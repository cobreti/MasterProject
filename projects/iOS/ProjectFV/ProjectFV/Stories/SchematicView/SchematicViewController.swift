//
//  SchematicViewController.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-06.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import DiagramElements
import Shapes

class SchematicViewController : UIViewController {
    
    var diagramLayer : DiagramLayer! {
        get {
            return _diagramLayer
        }
        set (value) {
            _diagramLayer = value
        }
    }
    
    var backEventHandler : EventHandler! {
        get {
            return _backEventHandler
        }
        set (value) {
            _backEventHandler = value
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        _diagramController = DiagramViewController(parentController: self)
        _diagramController.diagramLayer = diagramLayer

        pushController(_diagramController)
    }

    func pushController(controller : DiagramViewController) {
        
        if let oldController = _controllers.last {
            oldController.view.removeFromSuperview()
        }
        
        _controllers.append(controller)
        
        _diagramArea.addSubview(controller.view)
        
        UIView.animateWithDuration(
            NSTimeInterval(0.5), animations: {() -> Void in
                controller.view.frame = self._diagramArea.bounds
            }, completion: {(Bool) -> Void in
                controller.view.userInteractionEnabled = true
                controller.updatePortalRect()
            })
        
//        controller.view.userInteractionEnabled = true
//        controller.updatePortalRect()
    }
    
    func removeLastController() {
        
        if _controllers.count < 2 {
            return
        }
        
        let currentController = _controllers.last!
        
//        currentController.view.removeFromSuperview()
        _controllers.removeLast()
        
        let newController = _controllers.last!
        
        if let dgmView = currentController.view as? DiagramView {
            
            let pinPt = dgmView.pinPoint!
            let x = pinPt.x + dgmView.frame.origin.x
            let y = pinPt.y + dgmView.frame.origin.y
            
            let dx = (dgmView.frame.size.width - 10) / 2
            let dy = (dgmView.frame.size.height - 10) / 2
            
            let newViewFrame = CGRect(x: -dx, y: -dy, width: _diagramArea.bounds.width + dx*2, height: _diagramArea.bounds.height + dy*2)
            newController.view.frame = newViewFrame
            newController.view.alpha = 0.0
            newController.resetView()
            _diagramArea.addSubview(newController.view)
            currentController.view.alpha = 1.0
            
            UIView.animateWithDuration(
                NSTimeInterval(0.5),
                animations: { () -> Void in
                    currentController.view.alpha = 0.0
                    newController.view.frame = self._diagramArea.bounds
                    newController.view.alpha = 1.0
                },
                completion: {(Bool) -> Void in
                    currentController.view.removeFromSuperview()
                    newController.resetView()
                })
        }        
    }

    @IBAction func onBack(sender: AnyObject) {
        if let handler = _backEventHandler {
            handler(sender: self, args: nil)
        }
    }
    
    @IBAction func onRecenter(sender: AnyObject) {

        _diagramController?.resetView()
    }
    
    var _diagramLayer : DiagramLayer!
    var _diagramController : DiagramViewController!
    var _backEventHandler : EventHandler!

    var _controllers : [DiagramViewController] = []

    
    @IBOutlet weak var _controlsArea: UIView!
    @IBOutlet weak var _diagramArea: UIView!
}


