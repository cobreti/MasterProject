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
        case normal
        case willShowSubDiagram
        case willShowParentDiagram
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
            _longPressGestureHandler?.enabled = value
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
    
    init(parentController: SchematicViewController, diagram: Diagram, originModelId: String!) {
        
        _parentController = parentController
        _diagram = diagram
        _originModelId = originModelId
        
        super.init(nibName: "DiagramView", bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        diagramView.prepareView()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        diagramView.cleanup()
    }


    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setSelectedElm( _ modelId: String! ) {
        if let dgmView = view as? DiagramView {
            dgmView.selectedModelId = modelId
        }
    }

    func deactivate() {
        
        view.removeFromSuperview()
    }
    
    func activateInView(_ parentView : UIView) {
        
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
        
        view.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        
        let frame = view.bounds

        _diagramPortal = DiagramPortal(
            rcArea: Rect( x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height ),
            diagramBox: _diagram.box )
        
        if let dgmView = view as? DiagramView {
            dgmView.diagram = _diagram
//            dgmView.navigationItemsGroup = _parentController.navigationHistory.currentGroup;
            dgmView.originModelId = _originModelId
            dgmView.diagramDocument = document
            dgmView.diagramPortal = _diagramPortal
            dgmView.pinPoint = PinPoint( x: frame.midX, y: frame.midY )
            dgmView.diagramViewsManager = _parentController.diagramViewsManager

            _panGestureHandler = PanGestureHandler(view: dgmView, portal: _diagramPortal)
            _zoomGestureHandler = ZoomGestureHandler(view: dgmView, portal: _diagramPortal)
            _tapGestureHandler = TapGestureHandler(view: dgmView, portal: _diagramPortal)
            _longPressGestureHandler = LongPressGestureHandler(view: dgmView, portal: _diagramPortal)
            _subDiagramPortal = SubDiagramPortal(view: dgmView, portal: _diagramPortal, parentController: _parentController)
            
            _panGestureHandler?.enabled = _gestureEnabled
            _zoomGestureHandler?.enabled = _gestureEnabled
            _tapGestureHandler?.enabled = _gestureEnabled
            _longPressGestureHandler?.enabled = _gestureEnabled
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let frame = view.bounds

        if let dgmView = view as? DiagramView {
            dgmView.drawingMode = _viewDrawingMode
            dgmView.pinPoint = PinPoint( x: frame.midX, y: frame.midY )
            _diagramPortal.viewRect = Rect( cgrect: frame )
            _diagramPortal.alignWithViewPinPoint(dgmView.pinPoint!)
            dgmView.setNeedsDisplay()
        }
    }
    
    func adjustAroundChild( _ childDiagramController: DiagramViewController ) {
        
        let childDiagramBox = childDiagramController._diagramPortal.boundingBox
        
        debugPrint("adjusting around child")
        
        if let  childDiagram = childDiagramController.diagram,
                let elm = getDiagramElementContainingChild(childDiagram),
                let box = elm.box,
                let dgmView = view as? DiagramView {

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
    
    func getDiagramElementContainingChild( _ childDiagram : Diagram ) -> Element! {
        
        let document = Application.instance().document

        debugPrint("looking for element containing \(childDiagram.name)")

        for (_, p) in _diagram.primitives {
            if let  elm = p as? Element,
                    let modelId = elm.modelId,
                    let model = document.models.get(modelId),
                    let subDiagramRef = model.subDiagrams.getForParentDiagram(childDiagram.name) {
                
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

    func enterSubDiagram(_ velocity: CGFloat) -> Bool {
        
        if let  portal = _subDiagramPortal,
                let ctrller = portal.subDiagramController,
                let diagram = ctrller.diagram {
            
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
    
    func setState( _ state: State ) {
    
        if _state != state {
            _state = state
            _parentController.onDiagramViewStateChanged(state)
        }
    }
    
    func onAction(_ action: Action) {
        
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

            case .LongPress:
                if let lpa = action as? LongPressAction {
                    onLongPressAction(lpa)
                }

            default:
                break
        }
    }
    
    func onPanAction(_ action: PanDiagramAction) {
    
        _diagramPortal.translation = action.translation
        _subDiagramPortal?.updateSubDiagramArea()
        view.setNeedsDisplay()
    }
    
    func onZoomAction(_ action: ZoomDiagramAction) {
        
        switch action.state {
            case .Began:
                _subDiagramPortal?.pickElm()

            case .Changed:
                _subDiagramPortal?.updateSubDiagramArea()
                
                if enterSubDiagram(action.velocity) {
                    setState(.willShowSubDiagram)
                }
                else if enterParentDiagram() {
                    setState(.willShowParentDiagram)
                }
                else {
                    setState(.normal)
                }
                
                view.setNeedsDisplay()
                
                _parentController.onDiagramChanged()

            case .Ended:
                _subDiagramPortal?.updateSubDiagramArea()
                
                setState(.normal)
                
                if enterSubDiagram(action.velocity) {
                    let subDiagramController = _subDiagramPortal.subDiagramController
                    let pickedElm = _subDiagramPortal?.pickedElement
                    _subDiagramPortal.detach()
                    Application.instance().actionsBus.send( EnterSubDiagramAction(subDiagramController: subDiagramController!, selectedElement: pickedElm, sender: nil) )

                }
                else if enterParentDiagram() {
                    
                    Application.instance().actionsBus.send( ExitSubDiagramAction(controller: self, sender:nil) )
                }
            
                view.setNeedsDisplay()

            case .Cancelled:
                break
        }
    }
    
    func onTapAction(_ action: TapDiagramAction) {
        
        let primitives = _diagram.primitivesFromPt(action.pt)
        
        if primitives.isEmpty {
            diagram.selection.clear()
        }
        else {
            for item in primitives {

                let document = Application.instance().document


                if let elm = item as? Element {

                    if let  v = view as? DiagramView,
                            let model = document.models.get(elm.modelId), model.fileReferences.empty {
                        v.selectedModelId = elm.modelId
                    }

                    Application.instance().actionsBus.send( SelectDiagramElementAction(element: elm, sender: self))
//                    _element = elm
                }
                
            }
        }
    }

    func onLongPressAction(_ action: LongPressAction) {

        let primitives = _diagram.primitivesFromPt(action.pt)

        if !primitives.isEmpty {

            var selectedElm : Element! = nil

            for item in primitives {
                if let elm = item as? Element {
                    selectedElm = elm
                    break
                }
            }

            let graphs = DisplayGraphs.instance


            if let  elm = selectedElm,

                    let graph = graphs.get(_diagram.name),
                    let graphElm = graph.items.get(elm.modelId) as? DisplayGraph_Element,
                    let _ = graphElm.subDiagramIcon {

//                _parentController.navigationHistory.currentGroup.next = NavigationItem(modelId: elm.modelId);

                if let v = view as? DiagramView {
                    v.selectedModelId = elm.modelId
                }

                switch action.state {

                    case .Began:
                        graphElm.state = .selected
                        _selectedGraphElement = graphElm
                        view?.setNeedsDisplay()
                        break;

                    case .Ended:
                        graphElm.state = .normal
                        _selectedGraphElement = nil
                        view?.setNeedsDisplay()

                        let document = Application.instance().document

                        if let  model = document.models.get(elm.modelId),
                                let ref = model.subDiagrams.getForParentDiagram(_diagram.name),
                                let subDiagram = document.diagrams.get(ref.diagramName) {

                            debugPrint("element selected : '\(elm.modelId)' in diagram : \(_diagram.name)")

                            Application.instance().actionsBus.send(ShowDiagramAction(diagram: subDiagram, originModelId: elm.modelId, sender: self))
                        }

//                        Application.instance().actionsBus.send( SelectDiagramElementAction(element: elm, sender: self))
                        break;

                    default:
                        break;
                }
            }
        }
        else {

            if let e = _selectedGraphElement {
                e.state = .normal
                _selectedGraphElement = nil
                view?.setNeedsDisplay()
            }
        }
    }

    var _diagramPortal : DiagramPortal!
    var _diagram : Diagram!
    var _parentController : SchematicViewController
    
    var _panGestureHandler : PanGestureHandler!
    var _zoomGestureHandler : ZoomGestureHandler!
    var _tapGestureHandler : TapGestureHandler!
    var _longPressGestureHandler : LongPressGestureHandler!
    var _subDiagramPortal : SubDiagramPortal!

    var _selectedGraphElement : DisplayGraph_Element!

    var _state : State = .normal
    
    var _gestureEnabled : Bool = true
    var _viewDrawingMode : ViewDrawingMode = .normal

    var _originModelId: String!
}
