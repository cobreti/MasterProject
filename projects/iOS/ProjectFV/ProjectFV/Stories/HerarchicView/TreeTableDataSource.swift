//
// Created by Danny Thibaudeau on 15-08-09.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class TreeTableDataSource : NSObject, UITableViewDataSource {

    var root: TreeItems! {
        get {
            return _root
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if _dirty {
            rebuildIndex()
        }

        return _nodeIndex.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("TreeViewCell") as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:"TreeViewCell")
        }

        let idx = indexPath.indexAtPosition(1)

        if idx < _nodeIndex.count {
            let node = _nodeIndex[idx]

            cell.textLabel?.text = node.item.name
        }
        else {

            cell.textLabel?.text = indexPath.description
        }

        return cell!
    }

    func addVisibleItem( item: TreeItem, parentNode: TreeTableDataNode! ) {

        if let parent = parentNode {
            parent.add( TreeTableDataNode(item: item) )
        }
        else {
            _nodes.append( TreeTableDataNode(item: item) )
        }

        setDirty()
    }

    func setDirty() {
        _dirty = true
    }

    func rebuildIndex() {

        _nodeIndex.removeAll(keepCapacity: true)

        for node in _nodes {

            _nodeIndex.append(node)
            node.forEachSubNodes(1, callback: {
                (level: Int, subNode: TreeTableDataNode) in
                    self._nodeIndex.append(subNode)
            } )
        }

        _dirty = false
    }

    func invalidate() {

        _nodes.removeAll(keepCapacity: true)

        _root.forEach( { (item: TreeItem) -> Void in
            self._nodes.append( TreeTableDataNode(item: item) )
        })

        setDirty()
    }

    var _root : TreeItems = TreeItems() // all possible tree items
    var _nodes : [TreeTableDataNode] = [] // tree of visible nodes
    var _nodeIndex : [TreeTableDataNode] = [] // index to visible nodes for table mapping
    var _dirty : Bool = false
}
