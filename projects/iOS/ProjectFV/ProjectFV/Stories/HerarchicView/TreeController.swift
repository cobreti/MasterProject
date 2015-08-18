//
// Created by Danny Thibaudeau on 15-08-08.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class TreeController : NSObject, UITableViewDelegate {

    var root: TreeItems! {
        get {
            return _dataSource.root
        }
    }

    init( table: UITableView ) {

        _table = table
        _dataSource = TreeTableDataSource()

        super.init()

        _table?.delegate = self
        _table?.dataSource = _dataSource
    }

    func invalidate() {

        _dataSource.invalidate()
        _table?.reloadData()
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if let node = _dataSource.getNodeFromIndexPath(indexPath) {

            let startIndex = indexPath.indexAtPosition(1) + 1
            let actionsBus = Application.instance().actionsBus

            if node.hasChildren {

                actionsBus.send( TreeItemCollapsed(node: node, sender: self) )

                let removedCount = _dataSource.collapse(node)
                let indexes: [NSIndexPath] = createIndexPaths( startIndex, count: removedCount )

                _table?.deleteRowsAtIndexPaths(indexes, withRowAnimation: UITableViewRowAnimation.Top)
            }
            else if node.item.children.count > 0 {

                actionsBus.send( TreeItemExpanded(node: node, sender:self) )

                let addedCount = _dataSource.expand(node)
                let indexes: [NSIndexPath] = createIndexPaths( startIndex, count: addedCount )

                _table?.insertRowsAtIndexPaths(indexes, withRowAnimation: UITableViewRowAnimation.Bottom)
            }
            else {

                actionsBus.send( TreeItemSelected(node: node, sender: self) )

            }
        }
    }

    func createIndexPaths( startIndex: Int, count: Int ) -> [NSIndexPath] {

        var indexes : [NSIndexPath] = []

        for (var idx : Int = 0; idx < count; ++idx) {
            let index = NSIndexPath(indexes: [0, idx + startIndex], length: 2)
            indexes.append(index)
        }

        return indexes
    }


    var _dataSource : TreeTableDataSource

    weak var _table : UITableView?
}
