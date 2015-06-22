//
// Created by Danny Thibaudeau on 15-05-02.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes

public class Primitive {

    public var box : Rect! {
        get {
            return _box
        }
        set (value) {
            _box = value
        }
    }
    
    public var id : String! {
        get {
            return _id
        }
        set (value) {
            _id = value
        }
    }
    
    public var uuid : NSUUID {
        get {
            return _uuid
        }
    }
    
    public var name : String! {
        get {
            return _name
        }
        set (value) {
            _name = value
        }
    }
    
    public var modelId : String! {
        get {
            return _modelId
        }
        set (value) {
            _modelId = value
        }
    }
    
    public var ownerDiagram : DiagramLayer! {
        get {
            return _diagram
        }
    }
    
    public init( ownerDiagram : DiagramLayer ) {

        _diagram = ownerDiagram
        _uuid = NSUUID()
    }
    
    public func onAdded() {
        
    }

    var _box : Rect!
    var _id : String!
    var _name : String!
    var _modelId : String!
    var _uuid : NSUUID
    
    weak var _diagram : DiagramLayer!
}

