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

    var toolbar : UIView! {
        get {
            return _toolbarController.view
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

//    var navigationHistory : NavigationHistory {
//        get {
//            return _navigationHistory
//        }
//    }
    
    init(diagram : Diagram) {
        _diagram = diagram

//        _navigationHistory.add(_diagram.name)

        super.init(nibName: "SchematicView", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _toolbarController?.diagramName = _diagram.name
//        _diagramNameLabel.text = _diagram.name
        
        _diagramViewsManager = DiagramViewsManager(schematicViewController: self, delegate: self)
        _diagramsHistoryController._diagramViewsManager = _diagramViewsManager

        _toolbarController.recenterDelegate = { () -> Void in
            self.onRecenter()
        }

        _toolbarController.showQuestionRechercheDelegate = { () -> Void in
            Application.instance().actionsBus.send( ShowQuestionRechercheAction(sender: self) )
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {

        _diagramViewsManager.activate( DiagramViewController(parentController: self, diagram: _diagram, originModelId: nil) )
    }

    func activate(_ controller: DiagramViewController, completionHandler: (() -> Void)! ) {
        
        controller.activateInView( _diagramArea )
        controller.viewDrawingMode = .normal
        
        UIView.animate(
            withDuration: TimeInterval(0.5), animations: {() -> Void in
                controller.view.frame = self._diagramArea.bounds
            }, completion: {(Bool) -> Void in
                controller.view.isUserInteractionEnabled = true
                controller.updatePortalRect()
                completionHandler?()
        })
    }
    
    func deactivate( _ controller: DiagramViewController, newController: DiagramViewController, completionHandler: (() -> Void)! ) {
     
        if let dgmView = controller.diagramView {
            let pinPt = dgmView.pinPoint!
            _ = pinPt.x + dgmView.frame.origin.x
            _ = pinPt.y + dgmView.frame.origin.y
            
            let dx = (dgmView.frame.size.width - 10) / 2
            let dy = (dgmView.frame.size.height - 10) / 2
            
            let newViewFrame = CGRect(x: -dx, y: -dy, width: _diagramArea.bounds.width + dx*2, height: _diagramArea.bounds.height + dy*2)
            newController.view.frame = newViewFrame
            newController.view.alpha = 0.0
            newController.resetView()
            newController.view.isUserInteractionEnabled = true
            newController.activateInView(_diagramArea)
            controller.view.alpha = 1.0
            
            UIView.animate(
                withDuration: TimeInterval(0.5),
                animations: { () -> Void in
                    controller.view.alpha = 0.0
                    newController.view.frame = self._diagramArea.bounds
                    newController.view.alpha = 1.0
                    newController.viewDrawingMode = .normal
                },
                completion: {(Bool) -> Void in
                    controller.deactivate()
                    newController.resetView()
                    completionHandler?()
            })
        }
        
//        _diagramNameLabel.text = newController.diagram.name
        _toolbarController?.diagramName = newController.diagram.name
    }
    
    func onDiagramViewStateChanged( _ state: DiagramViewController.State ) {
        
        switch state {
            case .normal:
                _upArrowImageView.removeFromSuperview()
                _downArrowImageView.removeFromSuperview()
                _leftArrowImageView.removeFromSuperview()
                _rightArrowImageView.removeFromSuperview()
                _tempParentController?.view.removeFromSuperview()
                _tempParentController = nil
                break
            case .willShowParentDiagram:
                onWillShowParentDiagram()
                break
            case .willShowSubDiagram:
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
            _tempParentController.view.isUserInteractionEnabled = false
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
    

    @IBAction func onBack(_ sender: AnyObject) {

        let app = Application.instance()

        app.actionsBus.send( RestartAction(sender: self) )

//        if let handler = _backEventHandler {
//            handler(sender: self, args: nil)
//        }
    }
    
    func onRecenter() {

        Application.instance().actionsBus.send( RecenterDiagramAction(sender: nil) )
    }
    
    func onDiagramViewActivated(    _ oldDiagramView: DiagramViewController!,
                                    newDiagramView: DiagramViewController ) {
     
        if let _ = oldDiagramView {
            _diagramsHistoryController.add(oldDiagramView)
        }
    }
    
    func onDiagramViewDeactivated(_ diagramView: DiagramViewController) {
        _diagramsHistoryController.remove(diagramView)
    }
    
    func onAction(_ action: Action) {
        
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

            case .ShowQuestionRecherche:
                Application.instance().stories.push( QuestionRecherchePopupStory() )


            case .ShowDiagram:
                if let sda = action as? ShowDiagramAction {
                    onShowDiagram(sda)
                }
            
            case .EnterSubDiagram:
                if let esda = action as? EnterSubDiagramAction {

                    if let  ctrller = diagramViewsManager.currentController,
                    let elm = esda.selectedElement {
                        ctrller.setSelectedElm(elm.modelId)
                    }

                    diagramViewsManager.activate(esda.subDiagramController)
                    _toolbarController?.diagramName = esda.subDiagramController.diagram.name
//                    _diagramNameLabel.text = esda.subDiagramController.diagram.name
                }

            case .ExitSubDiagram:
                if let esda = action as? ExitSubDiagramAction {
                    diagramViewsManager.deactivate(esda.subDiagramViewController)
                }

            case .RecenterDiagram:
                if let ctrller = _diagramViewsManager.currentController {
                    ctrller.resetView()
                }
            case .HistoryDiagramSelected:
                if let hdsa = action as? HistoryDiagramSelectedAction {
                    _toolbarController.diagramName = hdsa.diagramController.diagram.name
//                    _diagramNameLabel?.text = hdsa.diagramController.diagram.name
                }

            
            default:
                break
        }

        _diagramViewsManager.onAction(action)
        _diagramsHistoryController.onAction(action)
    }
    
    func onSelectDiagramElement(_ action: SelectDiagramElementAction) {
        let document = Application.instance().document
        
        if let  model = document.models.get(action.element.modelId) {

//            navigationHistory.currentGroup.next = NavigationItem(modelId: model.id);

            if let  currentController = _diagramViewsManager.currentController,
                    let currentDiagram = currentController.diagram,
                    let ref = model.fileReferences.getForParentDiagram(currentDiagram.name),
                    let rootPath = document.filesPathRoot {
                    
                let app = Application.instance()
                
                app.actionsBus.send( FileViewAction(file: rootPath + ref.path, sender: self))
//                    app.stories.push( FileViewStory(file: rootPath + filePath) )
            }
            else if let currentController = _diagramViewsManager.currentController,
                        let currentDiagram = currentController.diagram,
                        let ref = model.subDiagrams.getForParentDiagram(currentDiagram.name),
                        let subDiagram = document.diagrams.get(ref.diagramName), !diagramViewsManager.contains(ref.diagramName) {

                let app = Application.instance()

                app.actionsBus.send( ShowDiagramAction(diagram: subDiagram, originModelId: action.element.modelId, sender: self) )
//                    let  controller = DiagramViewController(parentController: self, diagram: subDiagram)
//                    diagramViewsManager.activate(controller)
            }

            if let currentController = _diagramViewsManager.currentController {
                currentController.setSelectedElm(action.element.modelId)
            }

        }
    }
    
    func onFileViewAction(_ action: FileViewAction) {

        let app = Application.instance()
        app.stories.push( FileViewStory(file: action.file) )
    }
    
    func onShowDiagram(_ action: ShowDiagramAction) {
        
//        _diagramNameLabel?.text = action.diagram.name
        _toolbarController?.diagramName = action.diagram.name
        
        let  controller = DiagramViewController(parentController: self, diagram: action.diagram, originModelId: action.originModelId)
        diagramViewsManager.activate(controller)
    }

    var _diagram : Diagram
    var _backEventHandler : EventHandler!
    var _tempParentController : DiagramViewController!
//    var _navigationHistory : NavigationHistory = NavigationHistory()

    var _diagramViewsManager : DiagramViewsManager!

    @IBOutlet var _upArrowImageView: UIImageView!
    @IBOutlet var _downArrowImageView: UIImageView!
    @IBOutlet var _leftArrowImageView: UIImageView!
    @IBOutlet var _rightArrowImageView: UIImageView!
    
    @IBOutlet var _toolbarController: SchematicViewTBController!
    @IBOutlet var _diagramsHistoryController: DiagramsHistoryController!
    @IBOutlet weak var _diagramArea: UIView!
    
}


