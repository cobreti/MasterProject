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

        let bundle = Bundle.main
//        let url = bundle.pathForResource("folder", ofType: "png")
        _folderImage = UIImage(named: "folder.png", in: bundle, compatibleWith: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if _dirty {
            rebuildIndex()
        }

        return _nodeIndex.count
    }

    func getNodeFromIndexPath( _ indexPath: IndexPath ) -> TreeTableDataNode! {

        let idx = indexPath.item

        if idx < _nodeIndex.count {
            return _nodeIndex[idx]
        }

        return nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if _dirty {
            rebuildIndex()
        }

        var cell : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "TreeViewCell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:"TreeViewCell")
        }

        let idx = indexPath.item

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

    func expand( _ node: TreeTableDataNode ) -> Int {

        let item = node.item
        var count : Int = 0

        item.children.forEach( { (subItem: TreeItem) -> Void in
            self.addVisibleItem(subItem, parentNode: node)
            count += 1
        })

        return count
    }

    func collapse( _ node: TreeTableDataNode ) -> Int {

        let count : Int = node.getSubNodesCount()

        node.removeChildNodes()
        setDirty()

        return count
    }

    func addVisibleItem( _ item: TreeItem, parentNode: TreeTableDataNode! ) {

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

        _nodeIndex.removeAll(keepingCapacity: true)

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

        _nodes.removeAll(keepingCapacity: true)

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
