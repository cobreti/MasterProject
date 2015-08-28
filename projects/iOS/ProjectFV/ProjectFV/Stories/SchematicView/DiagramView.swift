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
            let params = DisplayGraphDrawParams(    ctx: ctx,
                                                    portal: portal,
                                                    drawingMode: _drawingMode )

            if let graph = graphs.get(diagName) {

                graph.draw(params)
            }
            else if let graph = buildDisplayGraph() {
                graphs.add(graph)
                graph.draw(params)
            }
        }
    }

    func buildDisplayGraph() -> DisplayGraph! {

        if let  diag = _diagram {

            let diagName = diag.name
            var graph = DisplayGraph(name: diagName)

            for (id, prim) in diag.primitives {

                if let elm = prim as? Element {
                    createDisplayGraphElement(graph, elm: elm)
                }
                else if let lnk = prim as? Link {
                    createDisplayGraphLink(graph, lnk: lnk)
                }
            }

            return graph
        }

        return nil
    }

    func createDisplayGraphElement(graph: DisplayGraph, elm: Element) {

        var dgElm = DisplayGraph_Element(rect: elm.box)

        if let  doc = _document,
                model = doc.models.get(elm.modelId) {

            if let  path = model.filePath,
                    img = UIImage(named: "file.png", inBundle: NSBundle.mainBundle(), compatibleWithTraitCollection: nil) {
                dgElm.fileIcon = img
            }

            if let  name = model.subDiagramName,
                    subDiagram = doc.diagrams.get(name),
                    img = UIImage(named: "subdiagram.png", inBundle: NSBundle.mainBundle(), compatibleWithTraitCollection: nil) {
                dgElm.subDiagramIcon = img
            }
        }

        if let name = elm.name {
            dgElm.name = name
        }

        graph.items.add(dgElm)
    }

    func createDisplayGraphLink(graph: DisplayGraph, lnk: Link) {

        var dgLnk = DisplayGraph_Link(pts: lnk.segment, type: lnk.type)

        graph.items.add(dgLnk)

        if let  name = lnk.name,
                captionPos = lnk.captionPos {

            graph.items.add( DisplayGraph_Label(pos: captionPos, text: name) )
        }

        if let  multiplicityCaptionPos = lnk.multiplicityCaptionPos,
                doc = _document,
                model = doc.models.get(lnk.modelId) {

            if let  from = model.linkEndPointFrom,
                    multiplicity = from.multiplicity {
                graph.items.add( DisplayGraph_Label(pos: multiplicityCaptionPos, text: multiplicity) )
            }
            else if let to = model.linkEndPointTo,
                        multiplicity = to.multiplicity {
                graph.items.add( DisplayGraph_Label(pos: multiplicityCaptionPos, text: multiplicity) )
            }
        }

        if lnk.type == .generalization {

            var dgEndPt = DisplayGraph_GeneralizationEndPoint(  p1: lnk.segment.get(0),
                                                                p2: lnk.segment.get(1))
            graph.items.add(dgEndPt)
        }

        if lnk.type == .association {

            if let  doc = _document,
                    model = doc.models.get(lnk.modelId) {

                let count = lnk.segment.count

                if let endPtFrom = model.linkEndPointFrom {
                    switch endPtFrom.type {
                        case .composited:
                            let dgEndPt = DisplayGraph_CompositionEndPoint(p1: lnk.segment.get(0),
                                                                           p2: lnk.segment.get(1))
                            graph.items.add(dgEndPt)
                        case .shared:
                            let dgEndPt = DisplayGraph_SharedEndPoint(p1: lnk.segment.get(0),
                                                                      p2: lnk.segment.get(1))
                            graph.items.add(dgEndPt)
                        default:
                            break
                    }
                }

                if let endPtTo = model.linkEndPointTo {
                    switch endPtTo.type {
                        case .composited:
                            let dgEndPt = DisplayGraph_CompositionEndPoint(p1: lnk.segment.get(count - 1),
                                                                           p2: lnk.segment.get(count - 2))
                            graph.items.add(dgEndPt)
                        case .shared:
                            let dgEndPt = DisplayGraph_SharedEndPoint(p1: lnk.segment.get(count - 1),
                                                                      p2: lnk.segment.get(count - 2))
                            graph.items.add(dgEndPt)
                        default:
                            break
                    }
                }
            }
        }
    }

    var _portal : DiagramPortal?
    var _diagram : Diagram?
    var _document : Document?
    var _pinPoint : PinPoint?
    var _drawingMode : ViewDrawingMode = .Normal
    var _diagramViewsManager : DiagramViewsManager!
}

