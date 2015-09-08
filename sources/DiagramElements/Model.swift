//
//  Model.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-20.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class Model {
    
    public var id : String {
        get {
            return _id
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
    
    public var children : ModelsTable {
        get {
            return _children
        }
    }

    public var linkEndPointFrom : LinkEndPoint! {
        get {
            return _linkEndPointFrom
        }
        set (value) {
            _linkEndPointFrom = value
        }
    }
    
    public var linkEndPointTo : LinkEndPoint! {
        get {
            return _linkEndPointTo
        }
        set (value) {
            _linkEndPointTo = value
        }
    }
    
    public var fileReferences : FileReferences {
        get {
            return _fileReferences
        }
    }
    
    public var subDiagrams: ModelReferences {
        get {
            return _subDiagrams
        }
    }
    
    public var plainTextValue : String! {
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
    
    
    private var _id : String
    private var _name : String!
    private var _parent : Model!
    private var _linkEndPointTo : LinkEndPoint!
    private var _linkEndPointFrom : LinkEndPoint!
    private var _children : ModelsTable = ModelsTable()
    private var _plainTextValue : String!
    private var _subDiagrams : ModelReferences = ModelReferences()
    private var _fileReferences : FileReferences = FileReferences()
}

