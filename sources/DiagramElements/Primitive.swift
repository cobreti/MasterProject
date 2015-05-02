//
// Created by Danny Thibaudeau on 15-05-02.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class Primitive {

    public var x : Float! {
        get {
            return _x
        }
        set(value) {
            _x = value
        }
    }

    public var y : Float! {
        get {
            return _y
        }
        set(value) {
            _y = value
        }
    }

    public var width : Float! {
        get {
            return _width
        }
        set(value) {
            _width = value
        }
    }

    public var height : Float! {
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

    var _x : Float!
    var _y : Float!
    var _width : Float!
    var _height : Float!
    var _id : String!
    var _name : String!
}
