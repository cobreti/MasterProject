//
//  DiagramView.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-15.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements
import Shapes
import UIKit

class DiagramView : UIView {


    var diagramPortal : DiagramPortal? {
        get {
            return _portal
        }
        set (value) {
            _portal = value
        }
    }
    
    var diagram : Diagram? {
        get {
            return _diagram
        }
        set (value) {
            _diagram = value
        }
    }
    
    var diagramDocument : Document? {
        get {
            return _document
        }
        set (value) {
            _document = value
        }
    }
    
    var diagramViewsManager : DiagramViewsManager! {
        get {
            return _diagramViewsManager
        }
        set (value) {
            _diagramViewsManager = value
        }
    }
    
    var pinPoint : PinPoint? {
        get {
            return _pinPoint
        }
        set (value) {
            _pinPoint = value
        }
    }
    
    var drawingMode : ViewDrawingMode {
        get {
            return _drawingMode
        }
        set (value) {
            _drawingMode = value
        }
    }
    
    
    override func drawRect(dirtyRect: CGRect) {
        
        super.drawRect(dirtyRect)

        let ctx : CGContext = UIGraphicsGetCurrentContext()

        if let  diag = _diagram,
                portal = diagramPortal {

            let diagName = diag.name
            let graphs = DisplayGraphs.instance

            if let graph = graphs.get(diagName) {

                graph.draw(ctx, portal: portal)
            }
            else if let graph = buildDisplayGraph() {
                graphs.add(graph)
                graph.draw(ctx, portal: portal)
            }
        }

//        if let  diag = diagram,
//                portal = diagramPortal,
//                document = diagramDocument,
//                pinPt = pinPoint {
//
//            var ctx : CGContext = UIGraphicsGetCurrentContext()
//
//            let dd = DiagramDisplay(    targetRect: bounds,
//                                        diagram: diag,
//                                        document: document,
//                                        portal: portal,
//                                        viewPinPt: pinPt )
//            dd.viewDrawingMode = _drawingMode
//
//            dd.display(ctx)
//        }
    }

    func buildDisplayGraph() -> DisplayGraph! {

        if let  diag = _diagram {

            let diagName = diag.name
            var graph = DisplayGraph(name: diagName)

            for (id, prim) in diag.primitives {

                if let elm = prim as? Element {
                    graph.items.add( createDisplayGraphElement(elm) )
                }
                else if let lnk = prim as? Link {
                    graph.items.add( createDisplayGraphLink(lnk))
                }
            }

            return graph
        }

        return nil
    }

    func createDisplayGraphElement(elm: Element) -> DisplayGraph_Element {

        var dgElm = DisplayGraph_Element(rect: elm.box)

        if let  doc = _document,
                model = doc.models.get(elm.modelId) {

            if let  path = model.filePath,
                    img = UIImage(named: "file.png", inBundle: NSBundle.mainBundle(), compatibleWithTraitCollection: nil) {
                dgElm.fileIcon = img
            }

            if let name = model.subDiagramName {

            }
        }

        if let name = elm.name {
            dgElm.name = name
        }

        return dgElm
    }

    func createDisplayGraphLink(lnk: Link) -> DisplayGraph_Link {

        var dgLnk = DisplayGraph_Link(pts: lnk.segment, type: lnk.type)

        return dgLnk
    }

    var _portal : DiagramPortal?
    var _diagram : Diagram?
    var _document : Document?
    var _pinPoint : PinPoint?
    var _drawingMode : ViewDrawingMode = .Normal
    var _diagramViewsManager : DiagramViewsManager!
}

