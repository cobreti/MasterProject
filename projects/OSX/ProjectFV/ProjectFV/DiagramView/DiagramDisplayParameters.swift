//
//  DiagramDisplayParameters.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-03.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation


class DiagramDisplayParameters {
    
    var offset : CGPoint {
        get {
            return _offset
        }
        set (value) {
            _offset = value
        }
    }
    
    var scale : CGFloat {
        get {
            return _scale
        }
        set (value) {
            _scale = value
        }
    }
    
    var _offset : CGPoint = CGPoint(x: 0, y: 0)
    var _scale : CGFloat = 1.0
}
