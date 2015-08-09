//
// Created by Danny Thibaudeau on 15-08-02.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

@objc
class HierarchicViewController : UIViewController, KOTreeViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        parseSourceFolders()

        _kotreeViewController.delegate = self
        _kotreeViewController.createControl()
//        _kotreeViewController.invalidate()
    }

    public func listItemsAtPath(path: String) -> NSMutableArray {

        var ret : NSMutableArray = NSMutableArray()

        if let items = _treeItems[path] {
            for item in items {
                ret.addObject(item)
            }
        }

        return ret
    }

    func parseSourceFolders() {

        let fm = NSFileManager()
        let bundle = NSBundle.mainBundle()

        if let url = bundle.URLForResource("ProjectFV", withExtension: "", subdirectory: "EmbeddedRes/CodeSite") {
            let items = parseSourceFolderAtUrl(fm, basePath: "", url: url)
            _treeItems["/"] = items
        }
    }

    func parseSourceFolderAtUrl(fileManager: NSFileManager, basePath: String, url: NSURL, level: Int = 0, parentItem: KOTreeItem! = nil) -> [KOTreeItem] {

        debugPrintln("parsing content of '\(url)")

        var folders : [NSURL] = []
        var files : [NSURL] = []
        var retItems : [KOTreeItem] = []
        var itemBasePath = basePath

        if basePath == "" {
            itemBasePath = "/"
        }

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
            let p = basePath + "/\(folder.lastPathComponent!)"

            debugPrintln("folder : \(p)")

            var item = KOTreeItem()
            item.path = itemBasePath
            item.base = folder.lastPathComponent!
            item.ancestorSelectingItems = NSMutableArray()
            item.numberOfSubitems = 0
            item.submersionLevel = level
            item.parentSelectingItem = parentItem

            retItems.append(item)

            let items = parseSourceFolderAtUrl(fileManager, basePath: p, url: folder, level: level+1, parentItem: item)

            item.ancestorSelectingItems.addObjectsFromArray(items)
            item.numberOfSubitems = items.count

            _treeItems[p] = items
        }

        for file in files {
            let p = basePath + "/\(file.lastPathComponent!)"

            debugPrintln("file : \(p)")
            var item = KOTreeItem()
            item.path = itemBasePath
            item.base = file.lastPathComponent!
            item.ancestorSelectingItems = NSMutableArray()
            item.numberOfSubitems = 0
            item.submersionLevel = level
            item.parentSelectingItem = parentItem

            retItems.append(item)
        }

        return retItems
    }

    @IBOutlet var _kotreeViewController: KOTreeViewController!

    var _treeItems : [String:[KOTreeItem]] = [:]
}
