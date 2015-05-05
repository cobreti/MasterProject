//
//  Edge.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-04.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class Edge {

    public init( p1 : CGPoint, p2 : CGPoint ) {
        _p1 = p1
        _p2 = p2
    }
    
    var _p1 : CGPoint
    var _p2 : CGPoint
}

