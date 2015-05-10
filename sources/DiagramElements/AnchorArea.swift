//
//  AnchorArea.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-09.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes

public class AnchorArea {
    
    public var box : Rect {
        get {
            return _box
        }
    }
    
    public init( x : Double, y : Double, width : Double, height : Double ) {
        
        _box = Rect(x: x, y: y, width: width, height: height)
    }
    
    private var _box : Rect
}
