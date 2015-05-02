//
//  DiagramLayer.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-01.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation


public class DiagramLayer {

    public var width : Float {
        get {
            return _width
        }
    }
    
    public var height : Float {
        get {
            return _height
        }
    }

    public var name : String {
        get {
            return _name
        }
    }

    public init(name : String) {
        _name = name
    }
    
    var _width : Float = 0.0
    var _height : Float = 0.0
    var _name : String
}

