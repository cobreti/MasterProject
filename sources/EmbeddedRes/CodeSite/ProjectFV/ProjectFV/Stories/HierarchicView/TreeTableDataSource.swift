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

    override init() {
        super.init()

        let bundle = NSBundle.mainBundle()
//        let url = bundle.pathForResource("folder", ofType: "png")
        _folderImage = UIImage(named: "folder.png", inBundle: bundle, compatibleWithTraitCollection: nil)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if _dirty {
            rebuildIndex()
        }

        return _nodeIndex.count
    }

    func getNodeFromIndexPath( indexPath: NSIndexPath ) -> TreeTableDataNode! {

        let idx = indexPath.indexAtPosition(1)

        if idx < _nodeIndex.count {
            return _nodeIndex[idx]
        }

        return nil
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if _dirty {
            rebuildIndex()
        }

        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("TreeViewCell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:"TreeViewCell")
        }

        let idx = indexPath.indexAtPosition(1)

        if idx < _nodeIndex.count {
            let node = _nodeIndex[idx]

            cell.textLabel?.text = node.item.name
            cell.indentationLevel = node.level
            cell.indentationWidth = 50

            if node.item.children.count > 0 {
                cell.imageView?.image = _folderImage
            }
            else {
                cell.imageView?.image = nil
            }
        }
        else {

            cell.textLabel?.text = indexPath.description
        }

        return cell!
    }

    func expand( node: TreeTableDataNode ) -> Int {

        let item = node.item
        var count : Int = 0

        item.children.forEach( { (subItem: TreeItem) -> Void in
            self.addVisibleItem(subItem, parentNode: node)
            ++count
        })

        return count
    }

    func collapse( node: TreeTableDataNode ) -> Int {

        let count : Int = node.getSubNodesCount()

        node.removeChildNodes()
        setDirty()

        return count
    }

    func addVisibleItem( item: TreeItem, parentNode: TreeTableDataNode! ) {

        if let parent = parentNode {
            parent.add( TreeTableDataNode(item: item, level: parent.level+1) )
        }
        else {
            _nodes.append( TreeTableDataNode(item: item, level: 0) )
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
            self._nodes.append( TreeTableDataNode(item: item, level: 0) )
        })

        setDirty()
    }

    var _root : TreeItems = TreeItems() // all possible tree items
    var _nodes : [TreeTableDataNode] = [] // tree of visible nodes
    var _nodeIndex : [TreeTableDataNode] = [] // index to visible nodes for table mapping
    var _dirty : Bool = false
    var _folderImage : UIImage!
}
