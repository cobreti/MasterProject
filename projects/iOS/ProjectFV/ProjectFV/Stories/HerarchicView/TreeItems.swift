//
// Created by Danny Thibaudeau on 15-08-08.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class TreeItems {

    var count: Int {
        get {
            return _items.count
        }
    }

    func getItemAtIndex(index: Int) -> TreeItem! {

        return _items[index]
    }

    func add(item: TreeItem) {
        _items.append(item)
    }

    func forEach( callback: (item: TreeItem) -> Void ) {

        for item in _items {
            callback(item: item)
        }
    }

    var _items : [TreeItem] = []
}
