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
    
    var diagramPortal : DiagramPortal! {
        get {
            return _diagramPortal
        }
    }
    
    var diagramLayer : DiagramLayer! {
        get {
            return _diagramLayer
        }
        set (value) {
            _diagramLayer = value
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let document = Application.instance().document
        
        view.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        
        let frame = view.bounds

        _diagramPortal = DiagramPortal(
            rcArea: Rect( x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height ),
            diagramBox: _diagramLayer.box )
        
        if let dgmView = view as? DiagramView {
            dgmView.diagramLayer = _diagramLayer
            dgmView.diagramDocument = document
            dgmView.diagramPortal = _diagramPortal
            dgmView.pinPoint = PinPoint( x: frame.midX, y: frame.midY )

            _panGestureHandler = PanGestureHandler(view: dgmView, portal: _diagramPortal, delegate: self)
            _zoomGestureHandler = ZoomGestureHandler(view: dgmView, portal: _diagramPortal, delegate: self)
            _tapGestureHandler = TapGestureHandler(view: dgmView, portal: _diagramPortal, delegate: self)
            _subDiagramPortal = SubDiagramPortal(view: dgmView, portal: _diagramPortal)
            
            _panGestureHandler?.enabled = _gestureEnabled
            _zoomGestureHandler?.enabled = _gestureEnabled
            _tapGestureHandler?.enabled = _gestureEnabled
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let frame = view.bounds

        if let dgmView = view as? DiagramView {
            dgmView.pinPoint = PinPoint( x: frame.midX, y: frame.midY )
            _diagramPortal.viewRect = Rect( cgrect: frame )
            _diagramPortal.alignWithViewPinPoint(dgmView.pinPoint!)
            dgmView.setNeedsDisplay()
        }
    }
    
    func updatePortalRect() {
        
        let frame = view.bounds
        
        if let dgmView = view as? DiagramView {
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
    }
    
    func onGestureEnded() {
        _subDiagramPortal?.updateSubDiagramArea()
    }

    var _diagramPortal : DiagramPortal!
    var _diagramLayer : DiagramLayer!
    
    var _panGestureHandler : PanGestureHandler!
    var _zoomGestureHandler : ZoomGestureHandler!
    var _tapGestureHandler : TapGestureHandler!
    var _subDiagramPortal : SubDiagramPortal!
    
    var _gestureEnabled : Bool = true
}
