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

    public var type : LinkType {
        get {
            return _type
        }
    }
    
    public var segment : Polyline {
        get {
            return _segment
        }
    }

    public var captionPos : Point! {
        get {
            return _captionPos
        }
        set (value) {
            _captionPos = value
        }
    }

    public var multiplicityCaptionPos : Point! {
        get {
            return _multiplicityCaptionPos
        }
        set (value) {
            _multiplicityCaptionPos = value
        }
    }
    
    public init( ownerDiagram : Diagram, type : LinkType ) {

        _type = type

        super.init(ownerDiagram: ownerDiagram)
    }
    
    
    var _to : LinkEndPoint!
    var _from : LinkEndPoint!
    var _type : LinkType
    var _captionPos : Point!
    var _multiplicityCaptionPos : Point!

    var _segment : Polyline! = Polyline()
}
