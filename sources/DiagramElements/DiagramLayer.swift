//
//  DiagramLayer.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-01.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation


public class DiagramLayer : DebugPrintable {

    public var width : CGFloat {
        get {
            return _width
        }
    }
    
    public var height : CGFloat {
        get {
            return _height
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
    }

    public func updateBoundingBox() {
        
        for (id, p) in _primitives {
            
            if let  x = p.x,
                    y = p.y,
                    w = p.width,
                    h = p.height {
                    
                _x = min(_x, x)
                _y = min(_y, y)
                _width = max(_width, w + abs(x))
                _height = max(_height, h + abs(y))
            }
        }
    }
    
    public var debugDescription: String {
        get {
            var dbg = "DiagramLayer pos = (\(_x), \(_y)) size = (\(_width), \(_height))"
            
            for (id, p) in _primitives {
                
                if let name = p.name,
                        x = p.x,
                        y = p.y,
                        w = p.width,
                        h = p.height {
                        
                    dbg += "\n     --> \(name) at (\(x), \(y)) of size (\(w), \(y))"
                }
            }
            
            return dbg
        }
    }
    
    var _x : CGFloat = 0.0
    var _y : CGFloat = 0.0
    var _width : CGFloat = 0.0
    var _height : CGFloat = 0.0
    var _name : String

    var _primitives : [String : Primitive] = [:]
}

