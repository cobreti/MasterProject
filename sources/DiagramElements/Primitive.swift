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
    
    public var anchorAreas : AnchorAreas {
        get {
            return _anchorAreas
        }
    }

    public init( ownerDiagram : DiagramLayer ) {

        _diagram = ownerDiagram
    }
    
    public func onAdded() {
        
        if let  x = box?.pos.x,
                y = box?.pos.y,
                w = box?.size.width,
                h = box?.size.height {
                    
            _anchorAreas.add("top", area: AnchorArea(x: x, y: y, width: w, height: 0))
            _anchorAreas.add("bottom", area: AnchorArea(x: x, y: y+h, width: w, height: 0))
            _anchorAreas.add("left", area: AnchorArea(x: x, y: y, width: 0, height: h))
            _anchorAreas.add("right", area: AnchorArea(x: x+w, y: y, width: 0, height: h))
        }
    }

    var _box : Rect!
    var _id : String!
    var _name : String!
    var _anchorAreas : AnchorAreas = AnchorAreas()
    
    weak var _diagram : DiagramLayer!
}

