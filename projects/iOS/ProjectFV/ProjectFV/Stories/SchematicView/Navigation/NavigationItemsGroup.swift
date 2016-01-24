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

    var next : NavigationItem! {
        get {
            return _next
        }
        set (value) {
            _next = value
        }
    }

    init( diagramName : String ) {
        _diagramName = diagramName
    }

    let _diagramName : String
    var _next : NavigationItem!
}
