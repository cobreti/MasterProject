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
    
    public var filePath : String! {
        get {
            return _filePath
        }
        set (value) {
            _filePath = value
        }
    }
    
    public var subDiagramName : String! {
        get {
            return _subDiagramName
        }
        set (value) {
            _subDiagramName = value
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
    private var _parent : Model!
    private var _linkEndPointTo : LinkEndPoint!
    private var _linkEndPointFrom : LinkEndPoint!
    private var _children : ModelsTable = ModelsTable()
    private var _filePath : String!
    private var _subDiagramName : String!
    private var _plainTextValue : String!
}

