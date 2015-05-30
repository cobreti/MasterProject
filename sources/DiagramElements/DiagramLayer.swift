//
//  DiagramLayer.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-01.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes


public class DiagramLayer : DebugPrintable {

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

    public init(name : String) {
        _name = name
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
    }
    
    public var debugDescription: String {
        get {
            return ""
        }
    }

    var _box : Rect!
    var _name : String

    var _primitives : [String : Primitive] = [:]
}

