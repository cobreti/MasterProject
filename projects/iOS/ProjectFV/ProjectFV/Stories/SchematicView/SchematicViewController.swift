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
                self._diagramController = controller
                self._diagramLayer = self._diagramController.diagramLayer
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
            newController.view.userInteractionEnabled = true
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
                    self._diagramController = newController
                    self._diagramLayer = self._diagramController.diagramLayer
                })
        }        
    }
    
    func onDiagramViewStateChanged( state: DiagramViewController.State ) {
        
        switch state {
            case .Normal:
                _upArrowImageView.removeFromSuperview()
                _downArrowImageView.removeFromSuperview()
                _leftArrowImageView.removeFromSuperview()
                _rightArrowImageView.removeFromSuperview()
                _tempParentController?.view.removeFromSuperview()
                _tempParentController = nil
                break
            case .WillShowParentDiagram:
                onWillShowParentDiagram()
                break
            case .WillShowSubDiagram:
                onWillShowSubDiagram()
                break
        }
    }
    
    func onDiagramChanged() {
        
        if let ctrller = _tempParentController {
            ctrller.adjustAroundChild(_diagramController)
        }
    }
    
    func onWillShowParentDiagram() {
        
        if _controllers.count < 2 {
            return
        }
        
        let rc = _diagramArea.bounds
        
        _upArrowImageView.frame = CGRect(x: rc.midX-10, y: rc.size.height-20, width: 20, height: 20)
        _diagramArea.addSubview(_upArrowImageView)
        
        _downArrowImageView.frame = CGRect(x: rc.midX-10, y: 0, width: 20, height: 20)
        _diagramArea.addSubview(_downArrowImageView)
        
        _leftArrowImageView.frame = CGRect(x: rc.size.width-20, y: rc.midY-10, width: 20, height: 20)
        _diagramArea.addSubview(_leftArrowImageView)
        
        _rightArrowImageView.frame = CGRect(x: 0, y: rc.midY-10, width: 20, height: 20)
        _diagramArea.addSubview(_rightArrowImageView)
        
        _tempParentController = _controllers[_controllers.count-2]
        _tempParentController.view.frame = _diagramArea.bounds
        _tempParentController.adjustAroundChild(_diagramController)
        _tempParentController.view.alpha = 0.5
        _tempParentController.view.userInteractionEnabled = false
        _diagramArea.addSubview(_tempParentController.view)
//        _diagramArea.sendSubviewToBack(_tempParentController.view)
        
    }
    
    func onWillShowSubDiagram() {
        
        let rc = _diagramArea.bounds
        
        _upArrowImageView.frame = CGRect(x: rc.midX-10, y: 0, width: 20, height: 20)
        _diagramArea.addSubview(_upArrowImageView)
        
        _downArrowImageView.frame = CGRect(x: rc.midX-10, y: rc.size.height-20, width: 20, height: 20)
        _diagramArea.addSubview(_downArrowImageView)
        
        _leftArrowImageView.frame = CGRect(x: 0, y: rc.midY-10, width: 20, height: 20)
        _diagramArea.addSubview(_leftArrowImageView)
        
        _rightArrowImageView.frame = CGRect(x: rc.size.width-20, y: rc.midY-10, width: 20, height: 20)
        _diagramArea.addSubview(_rightArrowImageView)
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
    var _tempParentController : DiagramViewController!

    var _controllers : [DiagramViewController] = []

    @IBOutlet var _upArrowImageView: UIImageView!
    @IBOutlet var _downArrowImageView: UIImageView!
    @IBOutlet var _leftArrowImageView: UIImageView!
    @IBOutlet var _rightArrowImageView: UIImageView!
    
    @IBOutlet weak var _controlsArea: UIView!
    @IBOutlet weak var _diagramArea: UIView!
    
}


