//
// Created by Danny Thibaudeau on 2016-01-03.
// Copyright (c) 2016 Danny Thibaudeau. All rights reserved.
//

import Foundation

class NavigationItemsGroup {

    var diagramName : String {
        get {
            return _diagramName
        }
    }

    init( diagramName : String ) {
        _diagramName = diagramName
    }

    let _diagramName : String
    var _items : [NavigationItem] = []
}
