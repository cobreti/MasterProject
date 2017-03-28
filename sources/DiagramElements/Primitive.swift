//
// Created by Danny Thibaudeau on 15-05-02.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes

open class Primitive {

    open var box : Rect! {
        get {
            return _box
        }
        set (value) {
            _box = value
        }
    }
    
    open var id : String! {
        get {
            return _id
        }
        set (value) {
            _id = value
        }
    }
    
    open var uuid : UUID {
        get {
            return _uuid
        }
    }
    
    open var name : String! {
        get {
            return _name
        }
        set (value) {
            _name = value
        }
    }
    
    open var modelId : String! {
        get {
            return _modelId
        }
        set (value) {
            _modelId = value
        }
    }
    
    open var ownerDiagram : Diagram! {
        get {
            return _diagram
        }
    }
    
    public init( ownerDiagram : Diagram ) {

        _diagram = ownerDiagram
        _uuid = UUID()
    }
    
    open func onAdded() {
        
    }

    var _box : Rect!
    var _id : String!
    var _name : String!
    var _modelId : String!
    var _uuid : UUID
    
    weak var _diagram : Diagram!
}

