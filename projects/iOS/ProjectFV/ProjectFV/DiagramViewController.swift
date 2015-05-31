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
        
        
        let frame = view.frame

        _diagramPortal = DiagramPortal(
            rcArea: Rect( x: Double(frame.origin.x), y: Double(frame.origin.y), width: Double(frame.size.width), height: Double(frame.size.height) ),
            diagramBox: _diagramLayer.box )
        
        if let dgmView = view as? DiagramView {
            dgmView.diagramLayer = _diagramLayer
            dgmView.diagramDocument = document
            dgmView.diagramPortal = _diagramPortal
            dgmView.pinPoint = PinPoint( x: Double(frame.midX), y: Double(frame.midY) )

            _panGestureHandler = PanGestureHandler(view: dgmView, portal: _diagramPortal)
            _zoomGestureHandler = ZoomGestureHandler(view: dgmView, portal: _diagramPortal)
//            _tapGestureHandler = TapGestureHandler(view: dgmView, portal: _diagramPortal)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let frame = view.frame

        if let dgmView = view as? DiagramView {
            dgmView.pinPoint = PinPoint( x: Double(frame.midX), y: Double(frame.midY) )
            _diagramPortal.viewRect = Rect( cgrect: frame )
            _diagramPortal.alignWithViewPinPoint(dgmView.pinPoint!)
            dgmView.setNeedsDisplay()
        }
    }
    
    
    func onZoom( sender : UIPinchGestureRecognizer ) {
//        debugPrintln("scale : \(sender.scale)")
        
        if ( sender.state == UIGestureRecognizerState.Began ) {
            sender.scale = CGFloat(_diagramPortal.zoom)
            
            var ptInView = sender.locationInView(view)
            let pt = PinPoint( x: Double(ptInView.x), y: Double(ptInView.y) )

            debugPrintln("ptInView : \(pt.x), \(pt.y)")

            if let dgmView = view as? DiagramView {
                dgmView.pinPoint = pt
                debugPrintln("current portal pinPt : \(_diagramPortal.pinPoint.x), \(_diagramPortal.pinPoint.y)")
                let portalPt = _diagramPortal.PointFromViewToPortal(pt)
                debugPrintln("portal point : \(portalPt.x), \(portalPt.y)")
                
                let pinPt = _diagramPortal.PointFromPortalToDiagram(portalPt)
                debugPrintln("pinPt portal -> diagram : \(pinPt.x), \(pinPt.y)")
                _diagramPortal.pinPoint = PinPoint(x: pinPt.x, y: pinPt.y)
            }
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            
            if let dgmView = view as? DiagramView {
//                _diagramPortal.alignWithViewPinPoint(dgmView.pinPoint!)
                _diagramPortal.zoom = Double(sender.scale)
                view.setNeedsDisplay()
            }
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            if let dgmView = view as? DiagramView {
//                _diagramPortal.alignWithViewPinPoint(dgmView.pinPoint!)
                view.setNeedsDisplay()
            }
        }
        
    }

    var _diagramPortal : DiagramPortal!
    var _diagramLayer : DiagramLayer!
    
    var _panGestureHandler : PanGestureHandler!
    var _zoomGestureHandler : ZoomGestureHandler!
    var _tapGestureHandler : TapGestureHandler!
}
