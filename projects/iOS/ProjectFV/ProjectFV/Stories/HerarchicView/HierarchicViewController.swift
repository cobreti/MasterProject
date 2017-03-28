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

        _toolbarController.showQuestionRechercheDelegate = { () -> Void in
            Application.instance().actionsBus.send( ShowQuestionRechercheAction(sender: self) )
        }
}
    
    var toolbar : UIView! {
        get {
            return _toolbarController.view
        }
    }

    func parseSourceFolders() {

        let fm = FileManager()
        let bundle = Bundle.main
        let doc = Application.instance().document

        if let  projectName = doc.projectName,
                let url = bundle.url(forResource: projectName, withExtension: "", subdirectory: "EmbeddedRes/CodeSite") {

            let relPath = "EmbeddedRes/CodeSite/\(projectName)"
            _ = parseSourceFolderAtUrl(fm, url: url, group: _treeController.root, relPath: relPath)
        }
    }

    func parseSourceFolderAtUrl(_ fileManager: FileManager, url: URL, group: TreeItems, relPath: String) {

        debugPrint("parsing content of '\(url)")

        var folders : [URL] = []
        var files : [URL] = []

        do {
            
            let content = try fileManager.contentsOfDirectory(  at: url,
                                                                includingPropertiesForKeys: nil,
                                                                options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles )

            for item in content {

                do {
                    _ = try fileManager.contentsOfDirectory(   at: item,
                                                                    includingPropertiesForKeys: nil,
                                                                    options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles )
                    folders.append(item)
                }
                catch _ {
                    files.append(item)
                }
            }
        }
        catch _ {
            
        }


        for folder in folders {

            let component = folder.lastPathComponent
            let subPath: String = relPath + "/\(component)"
            let item = TreeItem(name: component, path: subPath)
            group.add(item)

            parseSourceFolderAtUrl(fileManager, url: folder, group: item.children, relPath: subPath)
        }

        for file in files {

            let component = file.lastPathComponent
            let subPath: String = relPath + "/\(component)"
            let item = TreeItem(name: component, path: subPath)
            group.add(item)
        
        }
    }

    @IBAction func onHome(_ sender: AnyObject) {

        let app = Application.instance()

        app.actionsBus.send( RestartAction(sender: self) )
    }
    
    
    @IBOutlet weak var _tableView: UITableView!
    @IBOutlet var _toolbarController: HierarchicViewTBController!

    var _treeController : TreeController!
}
