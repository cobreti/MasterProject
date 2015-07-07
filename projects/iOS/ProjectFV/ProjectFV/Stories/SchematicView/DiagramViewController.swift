//
//  DiagramViewController.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-15.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements
import Shapes
import UIKit

class DiagramViewController : UIViewController, GestureHandlerDelegate {
    
    enum State {
        case Normal
        case WillShowSubDiagram
        case WillShowParentDiagram
    }
    
    var diagramPortal : DiagramPortal! {
        get {
            return _diagramPortal
        }
    }
    
    var diagram : Diagram! {
        get {
            return _diagram
        }
        set (value) {
            _diagram = value
        }
    }
    
    var diagramView : DiagramView! {
        get {
            return self.view as? DiagramView
        }
    }
    
    var gestureEnabled : Bool {
        get {
            return _gestureEnabled
        }
        set (value) {
            _gestureEnabled = value
            _panGestureHandler?.enabled = value
            _zoomGestureHandler?.enabled = value
            _tapGestureHandler?.enabled = value
        }
    }
    
    var viewDrawingMode : ViewDrawingMode {
        get {
            return _viewDrawingMode
        }
        set (value) {
            _viewDrawingMode = value
            
            if let v = diagramView {
                v.drawingMode = value
            }
        }
    }
    
    init(parentController: SchematicViewController, diagram: Diagram) {
        
        _parentController = parentController
        _diagram = diagram
        
        super.init(nibName: "DiagramView", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func deactivate() {
        
        view.removeFromSuperview()
    }
    
    func activateInView(parentView : UIView) {
        
        parentView.addSubview(view)
    }
    
    func resetView() {
        
        _diagramPortal.reset()
        _subDiagramPortal.reset()
        updatePortalRect()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let document = Application.instance().document
        
        view.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        
        let frame = view.bounds

        _diagramPortal = DiagramPortal(
            rcArea: Rect( x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height ),
            diagramBox: _diagram.box )
        
        if let dgmView = view as? DiagramView {
            dgmView.diagram = _diagram
            dgmView.diagramDocument = document
            dgmView.diagramPortal = _diagramPortal
            dgmView.pinPoint = PinPoint( x: frame.midX, y: frame.midY )
            dgmView.diagramViewsManager = _parentController.diagramViewsManager

            _panGestureHandler = PanGestureHandler(view: dgmView, portal: _diagramPortal, delegate: self)
            _zoomGestureHandler = ZoomGestureHandler(view: dgmView, portal: _diagramPortal, delegate: self)
            _tapGestureHandler = TapGestureHandler(view: dgmView, portal: _diagramPortal, delegate: self)
            _subDiagramPortal = SubDiagramPortal(view: dgmView, portal: _diagramPortal, parentController: _parentController)
            
            _panGestureHandler?.enabled = _gestureEnabled
            _zoomGestureHandler?.enabled = _gestureEnabled
            _tapGestureHandler?.enabled = _gestureEnabled
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let frame = view.bounds

        if let dgmView = view as? DiagramView {
            dgmView.drawingMode = _viewDrawingMode
            dgmView.pinPoint = PinPoint( x: frame.midX, y: frame.midY )
            _diagramPortal.viewRect = Rect( cgrect: frame )
            _diagramPortal.alignWithViewPinPoint(dgmView.pinPoint!)
            dgmView.setNeedsDisplay()
        }
    }
    
    func adjustAroundChild( childDiagramController: DiagramViewController ) {
        
        let childDiagramBox = childDiagramController._diagramPortal.boundingBox
        
        debugPrintln("adjusting around child")
        
        if let  childDiagram = childDiagramController.diagram,
                elm = getDiagramElementContainingChild(childDiagram),
                box = elm.box,
                dgmView = view as? DiagramView {

            debugPrintln("-- adjusting around child")

            _diagramPortal.pinPoint = PinPoint(x: box.midX, y: box.midY)
            dgmView.pinPoint = PinPoint(x: childDiagramBox.midX, y: childDiagramBox.midY)
            
            let dx = childDiagramBox.size.width / box.size.width
            let dy = childDiagramBox.size.height / box.size.height
                        
            _diagramPortal.zoom = max(dx, dy)

            _diagramPortal.viewRect = Rect( cgrect: view.bounds )
            _diagramPortal.updateScaling()
            _diagramPortal.alignWithViewPinPoint(dgmView.pinPoint!)
            dgmView.setNeedsDisplay()
        }

    }
    
    func getDiagramElementContainingChild( childDiagram : Diagram ) -> Element! {
        
        let document = Application.instance().document

        debugPrintln("looking for element containing \(childDiagram.name)")

        for (id, p) in _diagram.primitives {
            if let  elm = p as? Element,
                    modelId = elm.modelId,
                    model = document.models.get(modelId),
                    subDiagramName = model.subDiagramName {
                
                debugPrintln("- subDiagramName : \(subDiagramName)")
                
                if subDiagramName == childDiagram.name {
                    return elm
                }
            }
        }
        
        debugPrintln("--> no element found for child")

        return nil
    }
    
    func updatePortalRect() {
        
        let frame = view.bounds
        
        if let  dgmView = view as? DiagramView {
            dgmView.drawingMode = _viewDrawingMode
            dgmView.pinPoint = PinPoint( x: frame.midX, y: frame.midY )
            _diagramPortal.viewRect = Rect( cgrect: frame )
            _diagramPortal.alignWithViewPinPoint(dgmView.pinPoint!)
            dgmView.setNeedsDisplay()
        }
    }
    
    func onGestureStarted() {
    
        _subDiagramPortal?.pickElm()
    }
    
    func onGestureChanged() {
        _subDiagramPortal?.updateSubDiagramArea()

        if enterSubDiagram() {
            setState(.WillShowSubDiagram)
        }
        else if enterParentDiagram() {
            setState(.WillShowParentDiagram)
        }
        else {
            setState(.Normal)
        }
        
        _parentController.onDiagramChanged()
    }
    
    func onGestureEnded() {
        _subDiagramPortal?.updateSubDiagramArea()
        
        setState(.Normal)
        
        if enterSubDiagram() {
            _parentController.diagramViewsManager.activate(_subDiagramPortal.subDiagramController)
            _subDiagramPortal.detach()
        }
        else if enterParentDiagram() {
            _parentController.diagramViewsManager.deactivate(self)
//            _parentController.removeLastController()
        }
    }
    
    func enterSubDiagram() -> Bool {
        
        if let  portal = _subDiagramPortal,
                ctrller = portal.subDiagramController,
                diagram = ctrller.diagram {
            
            if _parentController.diagramViewsManager.contains(diagram.name) {
                return false
            }
            
            return portal.enterSubDiagram()
        }
        
        return false
    }
    
    func enterParentDiagram() -> Bool {
        
        let portalRect = _diagramPortal.rectFromDiagramToPortal(_diagram.box)
        return portalRect.size.width < 400 && portalRect.size.height < 400
    }
    
    func setState( state: State ) {
    
        if _state != state {
            _state = state
            _parentController.onDiagramViewStateChanged(state)
        }
    }

    var _diagramPortal : DiagramPortal!
    var _diagram : Diagram!
    var _parentController : SchematicViewController
    
    var _panGestureHandler : PanGestureHandler!
    var _zoomGestureHandler : ZoomGestureHandler!
    var _tapGestureHandler : TapGestureHandler!
    var _subDiagramPortal : SubDiagramPortal!
    
    var _state : State = .Normal
    
    var _gestureEnabled : Bool = true
    var _viewDrawingMode : ViewDrawingMode = .Normal
}
