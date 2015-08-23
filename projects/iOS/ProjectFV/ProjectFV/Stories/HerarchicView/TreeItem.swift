//
// Created by Danny Thibaudeau on 15-08-08.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class TreeItem {

    public var name: String {
        get {
            return _name
        }
    }

    public var path : String {
        get {
            return _path
        }
    }

    public var children: TreeItems {
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

