//
// Created by Danny Thibaudeau on 2016-01-02.
// Copyright (c) 2016 Danny Thibaudeau. All rights reserved.
//

import Foundation

class NavigationItem {

    var diagramName : String {
        get {
            return _diagramName
        }
    }

    var modelId : String {
        get {
            return _modelId
        }
    }

    init(diagramName: String, modelId: String) {
        _diagramName = diagramName
        _modelId = modelId
    }

    let _diagramName: String
    let _modelId: String
}
