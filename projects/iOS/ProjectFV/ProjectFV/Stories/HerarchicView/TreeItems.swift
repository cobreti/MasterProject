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

    func getItemAtIndex(_ index: Int) -> TreeItem! {

        return _items[index]
    }

    func add(_ item: TreeItem) {
        _items.append(item)
    }

    func forEach( _ callback: (_ item: TreeItem) -> Void ) {

        for item in _items {
            callback(item)
        }
    }

    var _items : [TreeItem] = []
}
