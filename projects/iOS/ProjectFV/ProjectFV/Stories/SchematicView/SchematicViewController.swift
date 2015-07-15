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

class SchematicViewController : UIViewController, DiagramViewsManagerDelegate {
    
    var diagramViewsManager: DiagramViewsManager! {
        get {
            return _diagramViewsManager
        }
    }
    
    var diagramAreaView : UIView {
        get {
            return _diagramArea
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
    
    init(diagram : Diagram) {
        _diagram = diagram
        
        super.init(nibName: "SchematicView", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _diagramViewsManager = DiagramViewsManager(schematicViewController: self, delegate: self)
        _diagramsHistoryController._diagramViewsManager = _diagramViewsManager
    }
    
    override func viewDidAppear(animated: Bool) {

        _diagramViewsManager.activate( DiagramViewController(parentController: self, diagram: _diagram) )
    }

    func activate(controller: DiagramViewController, completionHandler: (() -> Void)! ) {
        
        controller.activateInView( _diagramArea )
        controller.viewDrawingMode = .Normal
        
        UIView.animateWithDuration(
            NSTimeInterval(0.5), animations: {() -> Void in
                controller.view.frame = self._diagramArea.bounds
            }, completion: {(Bool) -> Void in
                controller.view.userInteractionEnabled = true
                controller.updatePortalRect()
                completionHandler?()
        })
    }
    
    func deactivate( controller: DiagramViewController, newController: DiagramViewController, completionHandler: (() -> Void)! ) {
     
        if let dgmView = controller.diagramView {
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
            newController.activateInView(_diagramArea)
            controller.view.alpha = 1.0
            
            UIView.animateWithDuration(
                NSTimeInterval(0.5),
                animations: { () -> Void in
                    controller.view.alpha = 0.0
                    newController.view.frame = self._diagramArea.bounds
                    newController.view.alpha = 1.0
                    newController.viewDrawingMode = .Normal
                },
                completion: {(Bool) -> Void in
                    controller.deactivate()
                    newController.resetView()
                    completionHandler?()
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
            ctrller.adjustAroundChild(_diagramViewsManager.currentController!)
        }
    }
    
    func onWillShowParentDiagram() {
        
        if let ctrller = _diagramViewsManager.parentDiagramController {
            
            let rc = _diagramArea.bounds
            
            _upArrowImageView.frame = CGRect(x: rc.midX-10, y: rc.size.height-20, width: 20, height: 20)
            _diagramArea.addSubview(_upArrowImageView)
            
            _downArrowImageView.frame = CGRect(x: rc.midX-10, y: 0, width: 20, height: 20)
            _diagramArea.addSubview(_downArrowImageView)
            
            _leftArrowImageView.frame = CGRect(x: rc.size.width-20, y: rc.midY-10, width: 20, height: 20)
            _diagramArea.addSubview(_leftArrowImageView)
            
            _rightArrowImageView.frame = CGRect(x: 0, y: rc.midY-10, width: 20, height: 20)
            _diagramArea.addSubview(_rightArrowImageView)
            
            _tempParentController = ctrller
            _tempParentController.view.frame = _diagramArea.bounds
            _tempParentController.adjustAroundChild(_diagramViewsManager.currentController!)
            _tempParentController.view.alpha = 0.5
            _tempParentController.view.userInteractionEnabled = false
            _diagramArea.addSubview(_tempParentController.view)
        }
        
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

        if let ctrller = _diagramViewsManager.currentController {
            ctrller.resetView()
        }
    }
    
    func onDiagramViewActivated(    oldDiagramView: DiagramViewController!,
                                    newDiagramView: DiagramViewController ) {
     
        if let ctrller = oldDiagramView {
            _diagramsHistoryController.add(oldDiagramView)
        }
    }
    
    func onDiagramViewDeactivated(diagramView: DiagramViewController) {
        _diagramsHistoryController.remove(diagramView)
    }
    
    func onAction(action: Action) {
        
        switch action.id {

            case .SelectDiagramElement:
                if let sdea = action as? SelectDiagramElementAction {
                    onSelectDiagramElement(sdea)
                }
                break
            
            case .FileView:
                if let fva = action as? FileViewAction {
                    onFileViewAction(fva)
                }
            
            case .ShowDiagram:
                if let sda = action as? ShowDiagramAction {
                    onShowDiagram(sda)
                }
            
            default:
                _diagramViewsManager.onAction(action)
        }
    }
    
    func onSelectDiagramElement(action: SelectDiagramElementAction) {
        let document = Application.instance().document
        
        if let  model = document.models.get(action.element.modelId) {
            
            if let  filePath = model.filePath,
                    rootPath = document.filesPathRoot {
                    
                let app = Application.instance()
                
                app.actionsBus.send( FileViewAction(file: rootPath + filePath, sender: self))
//                    app.stories.push( FileViewStory(file: rootPath + filePath) )
            }
            else if let name = model.subDiagramName,
                        subDiagram = document.diagrams.get(name) where !diagramViewsManager.contains(name) {
                        
                let app = Application.instance()
                
                app.actionsBus.send( ShowDiagramAction(diagram: subDiagram, sender: self) )
//                    let  controller = DiagramViewController(parentController: self, diagram: subDiagram)
//                    diagramViewsManager.activate(controller)
            }
            
        }
    }
    
    func onFileViewAction(action: FileViewAction) {

        let app = Application.instance()
        app.stories.push( FileViewStory(file: action.file) )
    }
    
    func onShowDiagram(action: ShowDiagramAction) {
        
        let  controller = DiagramViewController(parentController: self, diagram: action.diagram)
        diagramViewsManager.activate(controller)
    }

    var _diagram : Diagram
    var _backEventHandler : EventHandler!
    var _tempParentController : DiagramViewController!

    var _diagramViewsManager : DiagramViewsManager!

    @IBOutlet var _upArrowImageView: UIImageView!
    @IBOutlet var _downArrowImageView: UIImageView!
    @IBOutlet var _leftArrowImageView: UIImageView!
    @IBOutlet var _rightArrowImageView: UIImageView!
    
    @IBOutlet var _diagramsHistoryController: DiagramsHistoryController!
    @IBOutlet weak var _controlsArea: UIView!
    @IBOutlet weak var _diagramArea: UIView!
    
}


