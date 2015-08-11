//
// Created by Danny Thibaudeau on 15-08-09.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class TreeTableDataNode {

    var item : TreeItem {
        get {
            return _item
        }
    }

    var level : Int {
        get {
            return _level
        }
    }

    var nodes : [TreeTableDataNode] {
        get {
            return _childNodes
        }
    }

    var hasChildren : Bool {
        get {
            return _childNodes.count > 0
        }
    }

    init( item: TreeItem, level: Int ) {
        _item = item
        _level = level
    }

    func add(node: TreeTableDataNode) {
        _childNodes.append(node)
    }

    func forEachSubNodes( level: Int, callback: (level: Int, node: TreeTableDataNode) -> Void ) {

        for node in _childNodes {

            callback(level: level, node: node)
            node.forEachSubNodes(level+1, callback: callback)
        }
    }

    var _item : TreeItem
    var _level : Int = 0
    var _childNodes : [TreeTableDataNode] = []
}
