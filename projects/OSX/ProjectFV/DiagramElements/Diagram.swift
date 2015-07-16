//
//  DiagramLayer.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-01.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes


public class Diagram : DebugPrintable {

    public var box : Rect! {
        get {
            return _box
        }
    }

    public var name : String {
        get {
            return _name
        }
    }
    
    public var primitives : [String : Primitive] {
        get {
            return _primitives
        }
    }
    
    public var selection : LayerSelection {
        get {
            return _selection
        }
    }

    public init(name : String) {
        _name = name
        _selection = LayerSelection()
    }

    public func add( primitive : Primitive ) {

        _primitives[primitive.id] = primitive
        
        primitive.onAdded()
    }
    
    public func get( id : String ) -> Primitive! {
        return _primitives[id]
    }

    public func updateBoundingBox() {
        
        _box = nil
        
        for (id, p) in _primitives {
            
            if let layerBox = self.box {
                _box = Rect.union(layerBox, r2: p.box)
            }
            else {
                _box = p.box
            }
        }

        if _box == nil {
            _box = Rect(x: 0, y: 0, width: 50, height: 50)
        }
    }
    
    public var debugDescription: String {
        get {
            return ""
        }
    }
    
    public func primitivesFromPt(pt: Point) -> [Primitive] {
        var res : [Primitive] = []
        
        for (key, item) in _primitives {
            
            if let elm = item as? Element where elm.box.contains(pt) {
                res.append(elm)
            }
        }
        
        return res
    }

    var _box : Rect!
    var _name : String
    var _selection : LayerSelection

    var _primitives : [String : Primitive] = [:]
}

