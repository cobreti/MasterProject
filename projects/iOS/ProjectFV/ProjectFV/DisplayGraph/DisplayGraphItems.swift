//
// Created by Danny Thibaudeau on 15-08-15.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class DisplayGraphItems {

    init() {

    }

    func add(_ item: DisplayGraphItem) {
        _items.append(item)

        if let id = item.id {
            _itemsById[id] = item
        }
    }

    func get(_ id: String) -> DisplayGraphItem! {
        return _itemsById[id]
    }

    func clear() {
        _items.removeAll(keepingCapacity: false)
    }

    func forEach( _ fct: (_ item: DisplayGraphItem) -> Void ) {

        for item in _items {
            fct(item)
        }
    }

    var _items : [DisplayGraphItem] = []
    var _itemsById : [String:DisplayGraphItem] = [:]
}
