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

    func getSubNodesCount() -> Int {

        var count : Int = 0

        for node in _childNodes {
            count += 1
            count += node.getSubNodesCount()
        }

        return count
    }

    func add(_ node: TreeTableDataNode) {
        _childNodes.append(node)
    }

    func removeChildNodes() {

        _childNodes.removeAll(keepingCapacity: false)
    }

    func forEachSubNodes( _ level: Int, callback: (_ level: Int, _ node: TreeTableDataNode) -> Void ) {

        for node in _childNodes {

            callback(level, node)
            node.forEachSubNodes(level+1, callback: callback)
        }
    }

    weak var _item : TreeItem!
    var _level : Int = 0
    var _childNodes : [TreeTableDataNode] = []
}
