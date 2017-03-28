//
//  Polyline.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-15.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

open class Polyline {
    
    open var count : Int {
        get {
            return _pts.count
        }
    }
    
    open var first : Point {
        get {
            return _pts[0]
        }
    }
    
    open var last : Point {
        get {
            return _pts.last!
        }
    }
    
    public init() {
        
    }
    
    open func add( _ pt : Point ) {
        _pts.append(pt)
    }
    
    open func get( _ idx : Int ) -> Point {
        return _pts[idx]
    }
    
    fileprivate var _pts : [Point] = []
}
