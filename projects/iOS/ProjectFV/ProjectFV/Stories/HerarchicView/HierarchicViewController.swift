//
// Created by Danny Thibaudeau on 15-08-02.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class HierarchicViewController : UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        _treeController = TreeController(table: _tableView)

        parseSourceFolders()

        _treeController.invalidate()

//        _kotreeViewController.delegate = self
//        _kotreeViewController.createControl()
//        _kotreeViewController.invalidate()
    }

//    public func listItemsAtPath(path: String) -> NSMutableArray {
//
//        var ret : NSMutableArray = NSMutableArray()
//
//        if let items = _treeItems[path] {
//            for item in items {
//                ret.addObject(item)
//            }
//        }
//
//        return ret
//    }

    func parseSourceFolders() {

        let fm = NSFileManager()
        let bundle = NSBundle.mainBundle()

        if let url = bundle.URLForResource("ProjectFV", withExtension: "", subdirectory: "EmbeddedRes/CodeSite") {
            let items = parseSourceFolderAtUrl(fm, url: url, group: _treeController.root)
//            _treeItems["/"] = items
        }
    }

    func parseSourceFolderAtUrl(fileManager: NSFileManager, url: NSURL, group: TreeItems) {

        debugPrintln("parsing content of '\(url)")

        var folders : [NSURL] = []
        var files : [NSURL] = []
        var retItems : [KOTreeItem] = []
//        var itemBasePath = basePath

//        if basePath == "" {
//            itemBasePath = "/"
//        }

        if let content = fileManager.contentsOfDirectoryAtURL(  url,
                                                                includingPropertiesForKeys: nil,
                                                                options: NSDirectoryEnumerationOptions.SkipsHiddenFiles,
                                                                error: nil) as? [NSURL] {

            for item in content {
//                debugPrintln(item)

                if let subContent = fileManager.contentsOfDirectoryAtURL(   item,
                                                                            includingPropertiesForKeys: nil,
                                                                            options: NSDirectoryEnumerationOptions.SkipsHiddenFiles,
                                                                            error: nil) {
                    folders.append(item)
                }
                else {
                    files.append(item)
                }
            }
        }


        for folder in folders {
//            let p = basePath + "/\(folder.lastPathComponent!)"

//            debugPrintln("folder : \(p)")

            var item = TreeItem(name: folder.lastPathComponent!)
            group.add( item )
//            var item = KOTreeItem()
//            item.path = itemBasePath
//            item.base = folder.lastPathComponent!
//            item.ancestorSelectingItems = NSMutableArray()
//            item.numberOfSubitems = 0
//            item.submersionLevel = level
//            item.parentSelectingItem = parentItem
//
//            retItems.append(item)
//
            parseSourceFolderAtUrl(fileManager, url: folder, group: item.children )
//
//            item.ancestorSelectingItems.addObjectsFromArray(items)
//            item.numberOfSubitems = items.count
//
//            _treeItems[p] = items
        }

        for file in files {

            group.add( TreeItem(name: file.lastPathComponent!) )
//            let p = basePath + "/\(file.lastPathComponent!)"
//
//            debugPrintln("file : \(p)")
//            var item = KOTreeItem()
//            item.path = itemBasePath
//            item.base = file.lastPathComponent!
//            item.ancestorSelectingItems = NSMutableArray()
//            item.numberOfSubitems = 0
//            item.submersionLevel = level
//            item.parentSelectingItem = parentItem
//
//            retItems.append(item)
        }

//        return retItems
    }

    @IBOutlet weak var _tableView: UITableView!

    var _treeController : TreeController!
//    var _treeItems : [String:[KOTreeItem]] = [:]
}
