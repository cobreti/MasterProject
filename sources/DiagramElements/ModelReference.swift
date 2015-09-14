//
// Created by Danny Thibaudeau on 15-08-29.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class ModelReference {

    public var diagramId : String! {
        get {
            return _diagramId
        }
    }

    public var diagramName : String {
        get {
            return _diagramName
        }
    }

    public var diagramOrigin: String {
        get {
            return _diagramOrigin
        }
    }

    public init(id: String, name: String, origin: String) {

        _diagramId = id
        _diagramName = name
        _diagramOrigin = origin
    }

    var _diagramId : String
    var _diagramName : String
    var _diagramOrigin : String
}