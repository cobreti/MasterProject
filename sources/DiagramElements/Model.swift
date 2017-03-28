//
//  Model.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-20.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

open class Model {
    
    open var id : String {
        get {
            return _id
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
    
    open var children : ModelsTable {
        get {
            return _children
        }
    }

    open var linkEndPointFrom : LinkEndPoint! {
        get {
            return _linkEndPointFrom
        }
        set (value) {
            _linkEndPointFrom = value
        }
    }
    
    open var linkEndPointTo : LinkEndPoint! {
        get {
            return _linkEndPointTo
        }
        set (value) {
            _linkEndPointTo = value
        }
    }
    
    open var fileReferences : FileReferences {
        get {
            return _fileReferences
        }
    }
    
    open var subDiagrams: ModelReferences {
        get {
            return _subDiagrams
        }
    }
    
    open var plainTextValue : String! {
        get {
            return _plainTextValue
        }
        set (value) {
            _plainTextValue = value
        }
    }

    public init(id : String, parent: Model! = nil) {
        
        _id = id
    }
    
    
    fileprivate var _id : String
    fileprivate var _name : String!
    fileprivate var _parent : Model!
    fileprivate var _linkEndPointTo : LinkEndPoint!
    fileprivate var _linkEndPointFrom : LinkEndPoint!
    fileprivate var _children : ModelsTable = ModelsTable()
    fileprivate var _plainTextValue : String!
    fileprivate var _subDiagrams : ModelReferences = ModelReferences()
    fileprivate var _fileReferences : FileReferences = FileReferences()
}

