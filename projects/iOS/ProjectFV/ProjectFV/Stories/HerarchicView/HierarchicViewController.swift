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
        let doc = Application.instance().document

        if let  projectName = doc.projectName,
                url = bundle.URLForResource(projectName, withExtension: "", subdirectory: "EmbeddedRes/CodeSite") {

            let relPath = "EmbeddedRes/CodeSite/\(projectName)"
            let items = parseSourceFolderAtUrl(fm, url: url, group: _treeController.root, relPath: relPath)
        }
    }

    func parseSourceFolderAtUrl(fileManager: NSFileManager, url: NSURL, group: TreeItems, relPath: String) {

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

            if let component = folder.lastPathComponent {
                let subPath: String = relPath + "/\(component)"
                var item = TreeItem(name: component, path: subPath)
                group.add(item)

                parseSourceFolderAtUrl(fileManager, url: folder, group: item.children, relPath: subPath)
            }
        }

        for file in files {

            if let component = file.lastPathComponent {
                let subPath: String = relPath + "/\(component)"
                var item = TreeItem(name: component, path: subPath)
                group.add(item)
            }
        }
    }

    @IBAction func onHome(sender: AnyObject) {

        let app = Application.instance()

        app.actionsBus.send( RestartAction(sender: self) )
    }
    
    
    @IBOutlet weak var _tableView: UITableView!

    var _treeController : TreeController!
}
