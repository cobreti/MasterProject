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
    }

    func parseSourceFolders() {

        let fm = NSFileManager()
        let bundle = NSBundle.mainBundle()

        if let url = bundle.URLForResource("ProjectFV", withExtension: "", subdirectory: "EmbeddedRes/CodeSite") {
            let items = parseSourceFolderAtUrl(fm, url: url, group: _treeController.root)
        }
    }

    func parseSourceFolderAtUrl(fileManager: NSFileManager, url: NSURL, group: TreeItems) {

        debugPrintln("parsing content of '\(url)")

        var folders : [NSURL] = []
        var files : [NSURL] = []

        if let content = fileManager.contentsOfDirectoryAtURL(  url,
                                                                includingPropertiesForKeys: nil,
                                                                options: NSDirectoryEnumerationOptions.SkipsHiddenFiles,
                                                                error: nil) as? [NSURL] {

            for item in content {

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

            var item = TreeItem(name: folder.lastPathComponent!)
            group.add( item )

            parseSourceFolderAtUrl(fileManager, url: folder, group: item.children )
        }

        for file in files {

            group.add( TreeItem(name: file.lastPathComponent!) )
        }
    }

    @IBAction func onHome(sender: AnyObject) {

        let app = Application.instance()

        app.actionsBus.send( RestartAction(sender: self) )
    }
    
    
    @IBOutlet weak var _tableView: UITableView!

    var _treeController : TreeController!
}
