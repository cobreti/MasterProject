//
//  Vector2D.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-24.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

open class Vector2D {

    open var x : CGFloat {
        get {
            return _x
        }
        set (value) {
            _x = value
        }
    }

    open var y : CGFloat {
        get {
            return _y
        }
        set (value) {
            _y = value
        }
    }

    open var module : CGFloat {
        get {
            return sqrt( _x*_x + _y*_y )
        }
    }

    open var unitVector : Vector2D! {
        get {
            let m = self.module
            return Vector2D(x: _x / m, y: _y / m)
        }
    }

    public init(x : CGFloat, y : CGFloat) {
        _x = x
        _y = y
    }

    fileprivate var _x : CGFloat
    fileprivate var _y : CGFloat
}

