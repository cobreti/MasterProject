//
// Created by Danny Thibaudeau on 15-05-02.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes

public class Primitive {

    public var box : Rect! {
        get {
            return _box
        }
        set (value) {
            _box = value
        }
    }
    
    public var id : String! {
        get {
            return _id
        }
        set (value) {
            _id = value
        }
    }
    
    public var name : String! {
        get {
            return _name
        }
        set (value) {
            _name = value
        }
    }
    
    public var ownerDiagram : DiagramLayer! {
        get {
            return _diagram
        }
    }

    public init( ownerDiagram : DiagramLayer ) {

        _diagram = ownerDiagram
    }
    
    public func onAdded( layer : DiagramLayer ) {
        
        if let  x = box?.pos.x,
                y = box?.pos.y,
                w = box?.size.width,
                h = box?.size.height {

//                    _edges.append( Edge(p1: CGPoint(x: x, y: y), p2: CGPoint(x: x, y: y + h) ) )
//                    _edges.append( Edge(p1: CGPoint(x: x, y: y), p2: CGPoint(x: x + w, y: y) ) )
//                    _edges.append( Edge(p1: CGPoint(x: x + w, y: y), p2: CGPoint(x: x + w, y: y + h) ) )
//                    _edges.append( Edge(p1: CGPoint(x: x, y: y + h), p2: CGPoint(x: x + w, y: y + h) ) )
        }
    }

    var _box : Rect!
    var _id : String!
    var _name : String!
    var _anchorAreas : AnchorAreas = AnchorAreas()
    
    weak var _diagram : DiagramLayer!
}

