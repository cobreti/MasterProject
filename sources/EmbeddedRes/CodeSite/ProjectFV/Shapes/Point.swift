//
//  Point.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-09.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class Point {

    public var x : CGFloat {
        get {
            return _x
        }
        set (value) {
            _x = value
        }
    }
    
    public var y : CGFloat {
        get {
            return _y
        }
        set (value) {
            _y = value
        }
    }
    
    public init(x : CGFloat, y : CGFloat) {
        _x = x
        _y = y
    }
    
    public init(pt : Point) {
        _x = pt.x
        _y = pt.y
    }
    
    private var _x : CGFloat
    private var _y : CGFloat
}
