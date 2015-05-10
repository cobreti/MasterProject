//
//  Link.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-04.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

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
    
    public override init( ownerDiagram : DiagramLayer ) {
        super.init(ownerDiagram: ownerDiagram)
    }
    
    public func createAnchors() {
        
        createAnchorForId(_idFrom)
    }

    func createAnchorForId( id : String ) {
        
    }
    
    var _idFrom : String!
    var _idTo : String!
}
