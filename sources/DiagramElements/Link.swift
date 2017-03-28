//
//  Link.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-04.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes

open class Link : Primitive {
    
    
    open var to : LinkEndPoint! {
        get {
            return _to
        }
        set (value) {
            _to = value
        }
    }
    
    open var from : LinkEndPoint! {
        get {
            return _from
        }
        set (value) {
            _from = value
        }
    }

    open var type : LinkType {
        get {
            return _type
        }
    }
    
    open var segment : Polyline {
        get {
            return _segment
        }
    }

    open var captionPos : Point! {
        get {
            return _captionPos
        }
        set (value) {
            _captionPos = value
        }
    }

    open var multiplicityCaptionPos : Point! {
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
