//
// Created by Danny Thibaudeau on 15-08-08.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class TreeItem {

    internal var name: String {
        get {
            return _name
        }
    }

    internal var path : String {
        get {
            return _path
        }
    }

    internal var children: TreeItems {
        get {
            return _children
        }
    }

    init(name: String, path: String ) {
        _name = name
        _path = path
    }

    var _name : String
    var _path : String
    var _children : TreeItems = TreeItems()
}

