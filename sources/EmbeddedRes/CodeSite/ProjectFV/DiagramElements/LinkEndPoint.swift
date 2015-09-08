//
//  LinkEndPoint.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-20.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class LinkEndPoint {
    
    public var id : String {
        get {
            return _id
        }
    }

    public var multiplicity : String! {
        get {
            return _multiplicity
        }
        set (value) {
            _multiplicity = value
        }
    }
    
    public var type : LinkEndPointType {
        get {
            return _type
        }
        set (value) {
            _type = value
        }
    }
    
    public init(id : String! = nil) {
        _id = id
    }
    
    var _id : String!
    var _multiplicity : String!
    var _type : LinkEndPointType = LinkEndPointType.none
}
