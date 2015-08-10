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

            if node.hasChildren {

            }
            else {
                let addedCount = _dataSource.expand(node)
                let idxPos = indexPath.indexAtPosition(1)
                var indexes: [NSIndexPath] = []

                for (var idx : Int = 0; idx < addedCount; ++idx) {

                    let index = NSIndexPath(indexes: [0, idxPos+idx+1], length: 2)
                    indexes.append(index)
                }

                _table?.insertRowsAtIndexPaths(indexes, withRowAnimation: UITableViewRowAnimation.Bottom)
            }
        }
    }


    var _dataSource : TreeTableDataSource

    weak var _table : UITableView?
}
