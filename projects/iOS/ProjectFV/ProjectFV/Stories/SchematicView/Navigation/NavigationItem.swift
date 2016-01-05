//
// Created by Danny Thibaudeau on 2016-01-02.
// Copyright (c) 2016 Danny Thibaudeau. All rights reserved.
//

import Foundation

class NavigationItem {

    var modelId : String {
        get {
            return _modelId
        }
    }

    init(modelId: String) {
        _modelId = modelId
    }

    let _modelId: String
}
