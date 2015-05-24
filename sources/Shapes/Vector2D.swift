//
//  Vector2D.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-24.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class Vector2D {

    public var x : Double {
        get {
            return _x
        }
        set (value) {
            _x = value
        }
    }

    public var y : Double {
        get {
            return _y
        }
        set (value) {
            _y = value
        }
    }

    public var module : Double {
        get {
            return sqrt( _x*_x + _y*_y )
        }
    }

    public var unitVector : Vector2D! {
        get {
            let m = self.module
            return Vector2D(x: _x / m, y: _y / m)
        }
    }

    public init(x : Double, y : Double) {
        _x = x
        _y = y
    }

    private var _x : Double
    private var _y : Double
}

