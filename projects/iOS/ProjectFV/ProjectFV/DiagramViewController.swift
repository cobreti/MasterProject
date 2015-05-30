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
    
    var diagramPortal : DiagramPortal! {
        get {
            return _diagramPortal
        }
    }
    
    var diagramLayer : DiagramLayer! {
        get {
            return _diagramLayer
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let document = Application.instance().document
        _diagramLayer = document.layers.get("VpProject")
        
        view.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        
        var zoomRecognizer = UIPinchGestureRecognizer()
        zoomRecognizer.addTarget(self, action: "onZoom:")
        view.addGestureRecognizer(zoomRecognizer)

        let frame = view.frame

        _diagramPortal = DiagramPortal(
            rcArea: Rect( x: Double(frame.origin.x), y: Double(frame.origin.y), width: Double(frame.size.width), height: Double(frame.size.height) ),
            diagramBox: _diagramLayer.box )
        
        if let dgmView = view as? DiagramView {
            dgmView.diagramLayer = _diagramLayer
            dgmView.diagramDocument = document
            dgmView.diagramPortal = _diagramPortal
            dgmView.pinPoint = PinPoint( x: Double(frame.midX), y: Double(frame.midY) )
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let frame = view.frame

        if let dgmView = view as? DiagramView {
            dgmView.pinPoint = PinPoint( x: Double(frame.midX), y: Double(frame.midY) )
        }
        
        _diagramPortal.viewRect = Rect( cgrect: frame )

        view.setNeedsDisplay()
    }
    
    func onZoom( sender : UIPinchGestureRecognizer ) {
        debugPrintln("scale : \(sender.scale)")
        
        if ( sender.state == UIGestureRecognizerState.Began ) {
            sender.scale = CGFloat(_diagramPortal.zoom)
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            
            _diagramPortal.zoom = Double(sender.scale)
            view.setNeedsDisplay()
        }
        
    }

    var _diagramPortal : DiagramPortal!
    var _diagramLayer : DiagramLayer!
}
