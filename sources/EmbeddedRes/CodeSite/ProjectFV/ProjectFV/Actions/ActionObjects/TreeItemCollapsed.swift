//
// Created by Danny Thibaudeau on 15-08-17.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class TreeItemCollapsed : Action {

    override var description: String {
        get {
            return " \(_node.item.name)"
        }
    }

    init(node: TreeTableDataNode, sender: AnyObject!) {

        _node = node

        super.init(id: .TreeItemExpanded, sender: sender)
    }

    var _node : TreeTableDataNode
}
