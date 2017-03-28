//
//  Size.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-09.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

open class Size {
    
    open var width : CGFloat {
        get {
            return _width
        }
        set (value) {
            _width = value
        }
    }
    
    open var height : CGFloat {
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
    
    fileprivate var _width : CGFloat
    fileprivate var _height : CGFloat
}
