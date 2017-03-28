//
//  DiagramLayer.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-01.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes


open class Diagram : CustomDebugStringConvertible {

    open var box : Rect! {
        get {
            return _box
        }
    }

    open var name : String {
        get {
            return _name
        }
    }
    
    open var primitives : [String : Primitive] {
        get {
            return _primitives
        }
    }
    
    open var selection : LayerSelection {
        get {
            return _selection
        }
    }

    public init(name : String) {
        _name = name
        _selection = LayerSelection()
    }

    open func add( _ primitive : Primitive ) {

        _primitives[primitive.id] = primitive
        
        primitive.onAdded()
    }
    
    open func get( _ id : String ) -> Primitive! {
        return _primitives[id]
    }

    open func updateBoundingBox() {
        
        _box = nil
        
        for (_, p) in _primitives {
            
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
    
    open var debugDescription: String {
        get {
            return ""
        }
    }
    
    open func primitivesFromPt(_ pt: Point) -> [Primitive] {
        var res : [Primitive] = []
        
        for (_, item) in _primitives {
            
            if let elm = item as? Element, elm.box.contains(pt) {
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

