//
// Created by Danny Thibaudeau on 15-08-15.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class DisplayGraph {

    var name: String {
        get {
            return _name
        }
    }

    var items: DisplayGraphItems {
        get {
            return _items
        }
    }

    init(name: String) {
        _name = name
    }

    func draw(  params: DisplayGraphDrawParams ) {

        _items.forEach( { (item: DisplayGraphItem) -> Void in

            item.draw(params)
        })
    }

    var _name : String
    var _items : DisplayGraphItems = DisplayGraphItems()
}

