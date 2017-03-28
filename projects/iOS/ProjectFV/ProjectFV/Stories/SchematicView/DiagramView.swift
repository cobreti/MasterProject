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

//    var navigationItemsGroup : NavigationItemsGroup! {
//        get {
//            return _navigationItemsGroup
//        }
//        set (value) {
//            _navigationItemsGroup = value
//        }
//    }

    var originModelId: String! {
        get {
            return _originModelId
        }
        set (value) {
            _originModelId = value
        }
    }

    var selectedModelId : String! {
        get {
            return _selectedModelId
        }
        set (value) {
            if ( value != _selectedModelId ) {
                _selectedModelId = value
                buildDisplayGraph()
                setNeedsDisplay()
            }
        }
    }

    func prepareView() {

        if let graph = buildDisplayGraph() {
            DisplayGraphs.instance.add(graph)
        }
    }

    func cleanup() {

        if let diag = _diagram {

            let graphs = DisplayGraphs.instance
            graphs.remove(diag.name)
        }
    }
    
    override func draw(_ dirtyRect: CGRect) {
        
        super.draw(dirtyRect)

        if let ctx : CGContext = UIGraphicsGetCurrentContext() {

            if let  diag = _diagram,
                    let portal = diagramPortal {

                let diagName = diag.name
                let graphs = DisplayGraphs.instance
                let params = DisplayGraphDrawParams(    ctx: ctx,
                                                        portal: portal,
                                                        drawingMode: _drawingMode )

                if let graph = graphs.get(diagName) {

                    graph.draw(params)
                }
    //            else if let graph = buildDisplayGraph() {
    //                graphs.add(graph)
    //                graph.draw(params)
    //            }
            }
        }
    }

    func buildDisplayGraph() -> DisplayGraph! {

        if let  diag = _diagram {

            let diagName = diag.name
            let graph = DisplayGraph(name: diagName)

            for (_, prim) in diag.primitives {

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

    func createDisplayGraphElement(_ graph: DisplayGraph, elm: Element) {

        let dgElm = DisplayGraph_Element(rect: elm.box)

        if let  doc = _document,
                let model = doc.models.get(elm.modelId) {

            if let  diagram = _diagram,
                    let _ = model.fileReferences.getForParentDiagram(diagram.name),
                    let img = UIImage(named: "file.png", in: Bundle.main, compatibleWith: nil) {
                dgElm.fileIcon = img
            }

            if let  diagram = _diagram,
                    let ref = model.subDiagrams.getForParentDiagram(diagram.name),
                    let _ = doc.diagrams.get(ref.diagramName),
                    let img = UIImage(named: "subdiagram.png", in: Bundle.main, compatibleWith: nil), !diagramViewsManager.contains(ref.diagramName) {
                dgElm.subDiagramIcon = img
            }
        }

        if let  oModelId = _originModelId,
                let img = UIImage(named: "origin.png", in: Bundle.main, compatibleWith: nil), oModelId == elm.modelId {
            dgElm.originIcon = img
        }

        if let  oModelId = _selectedModelId,
        let img = UIImage(named: "last-chosen.png", in: Bundle.main, compatibleWith: nil), oModelId == elm.modelId {
            dgElm._lastSelectedIcon = img
        }

        dgElm.id = elm.modelId

        if let name = elm.name {
            dgElm.name = name
        }

        graph.items.add(dgElm)
    }

    func createDisplayGraphLink(_ graph: DisplayGraph, lnk: Link) {

        let dgLnk = DisplayGraph_Link(pts: lnk.segment, type: lnk.type)

        graph.items.add(dgLnk)

        if let  name = lnk.name,
                let captionPos = lnk.captionPos {

            graph.items.add( DisplayGraph_Label(pos: captionPos, text: name) )
        }

        if let  multiplicityCaptionPos = lnk.multiplicityCaptionPos,
                let doc = _document,
                let model = doc.models.get(lnk.modelId) {

            if let  from = model.linkEndPointFrom,
                    let multiplicity = from.multiplicity {
                graph.items.add( DisplayGraph_Label(pos: multiplicityCaptionPos, text: multiplicity) )
            }
            else if let to = model.linkEndPointTo,
                        let multiplicity = to.multiplicity {
                graph.items.add( DisplayGraph_Label(pos: multiplicityCaptionPos, text: multiplicity) )
            }
        }

        if lnk.type == .generalization {

            let dgEndPt = DisplayGraph_GeneralizationEndPoint(  p1: lnk.segment.get(0),
                                                                p2: lnk.segment.get(1))
            graph.items.add(dgEndPt)
        }

        if lnk.type == .association {

            if let  doc = _document,
                    let model = doc.models.get(lnk.modelId) {

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
    var _drawingMode : ViewDrawingMode = .normal
    var _diagramViewsManager : DiagramViewsManager!
//    var _navigationItemsGroup : NavigationItemsGroup!
    var _originModelId : String!
    var _selectedModelId : String!
}

