//
// Created by Danny Thibaudeau on 15-05-01.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

open class Document {

    open var diagrams : Diagrams {
        get {
            return _layers
        }
    }
    
    open var filesPathRoot : String! {
        get {
            return _filesPathRoot
        }
        set (value) {
            _filesPathRoot = value
        }
    }
    
    open var models : ModelsTable {
        get {
            return _models
        }
    }

    open var projectName : String! {
        get {
            return _projectName
        }
        set (value) {
            _projectName = value
        }
    }

    open func clear() {

        _filesPathRoot = nil
        _layers.clear()
        _models.clear()
    }

    public init() {

    }

    var _filesPathRoot : String!
    var _layers : Diagrams = Diagrams()
    var _models : ModelsTable = ModelsTable()
    var _projectName : String!
}
