//
//  Margins.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-18.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class Margins {
    
    public var left : Double {
        get {
            return _left
        }
        set (value) {
            _left = value
        }
    }
    
    public var top : Double {
        get {
            return _top
        }
        set (value) {
            _top = value
        }
    }
    
    public var right : Double {
        get {
            return _right
        }
        set (value) {
            _right = value
        }
    }
    
    public var bottom : Double {
        get {
            return _bottom
        }
        set (value) {
            _bottom = value
        }
    }
    
    public init( left : Double = 0, top : Double = 0, right : Double = 0, bottom : Double = 0 ) {
        
        _left = left
        _right = right
        _top = top
        _bottom = bottom
    }
    
    private var _left : Double = 0
    private var _right : Double = 0
    private var _top : Double = 0
    private var _bottom : Double = 0
}
