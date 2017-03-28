//
//  Margins.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-18.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

open class Margins {
    
    open var left : CGFloat {
        get {
            return _left
        }
        set (value) {
            _left = value
        }
    }
    
    open var top : CGFloat {
        get {
            return _top
        }
        set (value) {
            _top = value
        }
    }
    
    open var right : CGFloat {
        get {
            return _right
        }
        set (value) {
            _right = value
        }
    }
    
    open var bottom : CGFloat {
        get {
            return _bottom
        }
        set (value) {
            _bottom = value
        }
    }
    
    public init( left : CGFloat = 0, top : CGFloat = 0, right : CGFloat = 0, bottom : CGFloat = 0 ) {
        
        _left = left
        _right = right
        _top = top
        _bottom = bottom
    }
    
    fileprivate var _left : CGFloat = 0
    fileprivate var _right : CGFloat = 0
    fileprivate var _top : CGFloat = 0
    fileprivate var _bottom : CGFloat = 0
}
