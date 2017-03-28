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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let node = _dataSource.getNodeFromIndexPath(indexPath) {

            let startIndex = indexPath.item + 1
            let actionsBus = Application.instance().actionsBus

            if node.hasChildren {

                actionsBus.send( TreeItemCollapsed(node: node, sender: self) )

                let removedCount = _dataSource.collapse(node)
                let indexes: [IndexPath] = createIndexPaths( startIndex, count: removedCount )

                _table?.deleteRows(at: indexes, with: UITableViewRowAnimation.top)
            }
            else if node.item.children.count > 0 {

                actionsBus.send( TreeItemExpanded(node: node, sender:self) )

                let addedCount = _dataSource.expand(node)
                let indexes: [IndexPath] = createIndexPaths( startIndex, count: addedCount )

                _table?.insertRows(at: indexes, with: UITableViewRowAnimation.bottom)
            }
            else {

                actionsBus.send( TreeItemSelected(node: node, sender: self) )
                debugPrint("item selected for path : \(node.item.path)")
                actionsBus.send(FileViewAction(file: node.item.path, sender: self))
            }
        }
    }

    func createIndexPaths( _ startIndex: Int, count: Int ) -> [IndexPath] {

        var indexes : [IndexPath] = []

        for idx in 0 ..< count {
            let index = NSIndexPath(indexes: [0, idx + startIndex], length: 2) as IndexPath
            indexes.append(index)
        }

        return indexes
    }


    var _dataSource : TreeTableDataSource

    weak var _table : UITableView?
}
