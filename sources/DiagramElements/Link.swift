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
    
    public var anchorFrom : AnchorArea! {
        get {
            return _anchorFrom
        }
    }
    
    public var anchorTo : AnchorArea! {
        get {
            return _anchorTo
        }
    }
    
    public override init( ownerDiagram : DiagramLayer ) {
        super.init(ownerDiagram: ownerDiagram)
    }
    
    public func createAnchors() {
        
        _anchorFrom = getAnchorForId(_idFrom)
        _anchorTo = getAnchorForId(_idTo)
    }

    func getAnchorForId( id : String ) -> AnchorArea! {
        
        if let prim = self.ownerDiagram.get(id) {
            return prim.anchorAreas.getAreaContainedInRect(self.box)
        }
        
        return nil
    }
    
    var _idFrom : String!
    var _idTo : String!
    var _segment : Polyline! = Polyline()
    
    var _anchorFrom : AnchorArea!
    var _anchorTo : AnchorArea!
}
