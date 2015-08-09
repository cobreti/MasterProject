//
// Created by Danny Thibaudeau on 15-08-09.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class TreeSection {

    var items: TreeItems {
        get {
            return _items
        }
    }

    init(items: TreeItems) {

        _items = items
    }

    var _items : TreeItems
}
