//
// Created by Danny Thibaudeau on 15-05-02.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class Primitive {

    public var x : CGFloat! {
        get {
            return _x
        }
        set(value) {
            _x = value
        }
    }

    public var y : CGFloat! {
        get {
            return _y
        }
        set(value) {
            _y = value
        }
    }

    public var width : CGFloat! {
        get {
            return _width
        }
        set(value) {
            _width = value
        }
    }

    public var height : CGFloat! {
        get {
            return _height
        }
        set(value) {
            _height = value
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

    public init() {

    }
    
    public func onAdded( layer : DiagramLayer ) {
        
        if let  x = _x,
                y = _y,
                w = _width,
                h = _height {
                
                    _edges.append( Edge(p1: CGPoint(x: x, y: y), p2: CGPoint(x: x, y: y + h) ) )
                    _edges.append( Edge(p1: CGPoint(x: x, y: y), p2: CGPoint(x: x + w, y: y) ) )
                    _edges.append( Edge(p1: CGPoint(x: x + w, y: y), p2: CGPoint(x: x + w, y: y + h) ) )
                    _edges.append( Edge(p1: CGPoint(x: x, y: y + h), p2: CGPoint(x: x + w, y: y + h) ) )
        }
    }

    var _x : CGFloat!
    var _y : CGFloat!
    var _width : CGFloat!
    var _height : CGFloat!
    var _id : String!
    var _name : String!
    var _edges : [Edge] = []
}

