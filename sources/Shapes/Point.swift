//
//  Point.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-09.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class Point {

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
    
    public init(x : Double, y : Double) {
        _x = x
        _y = y
    }
    
    private var _x : Double
    private var _y : Double
}
