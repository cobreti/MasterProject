//
// Created by Danny Thibaudeau on 15-05-01.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class Document {

    public var diagrams : Diagrams {
        get {
            return _layers
        }
    }
    
    public var filesPathRoot : String! {
        get {
            return _filesPathRoot
        }
        set (value) {
            _filesPathRoot = value
        }
    }
    
    public var models : ModelsTable {
        get {
            return _models
        }
    }

    public var projectName : String! {
        get {
            return _projectName
        }
        set (value) {
            _projectName = value
        }
    }

    public func clear() {

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
