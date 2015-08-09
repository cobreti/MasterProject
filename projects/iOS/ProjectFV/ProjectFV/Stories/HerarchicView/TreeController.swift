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

    var _dataSource : TreeTableDataSource

    weak var _table : UITableView?
}
