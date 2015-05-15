//
//  Polyline.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-15.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class Polyline {
    
    public var count : Int {
        get {
            return _pts.count
        }
    }
    
    public var first : Point {
        get {
            return _pts[0]
        }
    }
    
    public var last : Point {
        get {
            return _pts.last!
        }
    }
    
    public init() {
        
    }
    
    public func add( pt : Point ) {
        _pts.append(pt)
    }
    
    public func get( idx : Int ) -> Point {
        return _pts[idx]
    }
    
    private var _pts : [Point] = []
}
