//
// Created by Danny Thibaudeau on 15-08-15.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class DisplayGraphItems {

    init() {

    }

    func add(item: DisplayGraphItem) {
        _items.append(item)
    }

    func clear() {
        _items.removeAll(keepCapacity: false)
    }

    func forEach( fct: (item: DisplayGraphItem) -> Void ) {

        for item in _items {
            fct(item: item)
        }
    }

    var _items : [DisplayGraphItem] = []
}
