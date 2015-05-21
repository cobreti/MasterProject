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
    
    
    public var to : LinkEndPoint! {
        get {
            return _to
        }
        set (value) {
            _to = value
        }
    }
    
    public var from : LinkEndPoint! {
        get {
            return _from
        }
        set (value) {
            _from = value
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
    
    
    var _to : LinkEndPoint!
    var _from : LinkEndPoint!
    
    var _segment : Polyline! = Polyline()
}
