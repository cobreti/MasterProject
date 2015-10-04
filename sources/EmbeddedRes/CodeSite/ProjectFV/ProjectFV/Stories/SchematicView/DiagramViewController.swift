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

class DiagramViewController : UIViewController {
    
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

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        diagramView.prepareView()
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)

        diagramView.cleanup()
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
        
        view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        
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

            _panGestureHandler = PanGestureHandler(view: dgmView, portal: _diagramPortal)
            _zoomGestureHandler = ZoomGestureHandler(view: dgmView, portal: _diagramPortal)
            _tapGestureHandler = TapGestureHandler(view: dgmView, portal: _diagramPortal)
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
        
        debugPrint("adjusting around child")
        
        if let  childDiagram = childDiagramController.diagram,
                elm = getDiagramElementContainingChild(childDiagram),
                box = elm.box,
                dgmView = view as? DiagramView {

            debugPrint("-- adjusting around child")

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

        debugPrint("looking for element containing \(childDiagram.name)")

        for (_, p) in _diagram.primitives {
            if let  elm = p as? Element,
                    modelId = elm.modelId,
                    model = document.models.get(modelId),
                    subDiagramRef = model.subDiagrams.getForParentDiagram(childDiagram.name) {
                
                debugPrint("- subDiagramName : \(subDiagramRef.diagramName)")
                
                if subDiagramRef.diagramName == childDiagram.name {
                    return elm
                }
            }
        }
        
        debugPrint("--> no element found for child")

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

    func enterSubDiagram(velocity: CGFloat) -> Bool {
        
        if let  portal = _subDiagramPortal,
                ctrller = portal.subDiagramController,
                diagram = ctrller.diagram {
            
            if _parentController.diagramViewsManager.contains(diagram.name) {
                return false
            }
            
            if velocity > 1.0 {
                return true
            }
            
//            return portal.enterSubDiagram()
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
    
    func onAction(action: Action) {
        
        switch action.id {
            
            case .PanDiagram:
                if let pda = action as? PanDiagramAction {
                    onPanAction(pda)
                }

            case .ZoomDiagram:
                if let zda = action as? ZoomDiagramAction {
                    onZoomAction(zda)
                }

            case .TapDiagram:
                if let tda = action as? TapDiagramAction {
                    onTapAction(tda)
                }
            
            default:
                break
        }
    }
    
    func onPanAction(action: PanDiagramAction) {
    
        _diagramPortal.translation = action.translation
        view.setNeedsDisplay()
    }
    
    func onZoomAction(action: ZoomDiagramAction) {
        
        switch action.state {
            case .Began:
                _subDiagramPortal?.pickElm()

            case .Changed:
                _subDiagramPortal?.updateSubDiagramArea()
                
                if enterSubDiagram(action.velocity) {
                    setState(.WillShowSubDiagram)
                }
                else if enterParentDiagram() {
                    setState(.WillShowParentDiagram)
                }
                else {
                    setState(.Normal)
                }
                
                view.setNeedsDisplay()
                
                _parentController.onDiagramChanged()

            case .Ended:
                _subDiagramPortal?.updateSubDiagramArea()
                
                setState(.Normal)
                
                if enterSubDiagram(action.velocity) {
                    let subDiagramController = _subDiagramPortal.subDiagramController
                    _subDiagramPortal.detach()
                    Application.instance().actionsBus.send( EnterSubDiagramAction(subDiagramController: subDiagramController, sender: nil) )

                }
                else if enterParentDiagram() {
                    
                    Application.instance().actionsBus.send( ExitSubDiagramAction(controller: self, sender:nil) )
                }
            
                view.setNeedsDisplay()
        }
    }
    
    func onTapAction(action: TapDiagramAction) {
        
        let primitives = _diagram.primitivesFromPt(action.pt)
        
        if primitives.isEmpty {
            diagram.selection.clear()
        }
        else {
            for item in primitives {
                
                if let elm = item as? Element {
                    Application.instance().actionsBus.send( SelectDiagramElementAction(element: elm, sender: self))
//                    _element = elm
                }
                
            }
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
