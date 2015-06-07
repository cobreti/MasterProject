//
//  Size.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-09.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class Size {
    
    public var width : CGFloat {
        get {
            return _width
        }
        set (value) {
            _width = value
        }
    }
    
    public var height : CGFloat {
        get {
            return _height
        }
        set (value) {
            _height = value
        }
    }
    
    public init(width : CGFloat, height : CGFloat) {
        _width = width
        _height = height
    }
    
    private var _width : CGFloat
    private var _height : CGFloat
}