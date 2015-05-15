//
//  Link.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-04.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes

public class Link : Primitive {
    
    public var idFrom : String! {
        get {
            return _idFrom
        }
        set (value) {
            _idFrom = value
        }
    }
    
    public var idTo : String! {
        get {
            return _idTo
        }
        set (value) {
            _idTo = value
        }
    }
    
    public var segment : Polyline {
        get {
            return _segment
        }
    }
    
    public override init( ownerDiagram : DiagramLayer ) {
        super.init(ownerDiagram: ownerDiagram)
    }
    
    
    var _idFrom : String!
    var _idTo : String!
    var _segment : Polyline! = Polyline()
}
