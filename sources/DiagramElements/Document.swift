//
// Created by Danny Thibaudeau on 15-05-01.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class Document {

    public var layers : DiagramLayers {
        get {
            return _layers
        }
    }

    public init() {

    }

    var _layers : DiagramLayers = DiagramLayers()
}
