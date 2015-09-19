//
// Created by Danny Thibaudeau on 15-08-14.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import VpProject

class ProjectSelectionViewController : UIViewController {

    func onActivated() {

        _ProjectFVBtn.enabled = true
        _NyxBtn.enabled = true
    }

    @IBAction func onProjectFVSelected(sender: AnyObject) {

        _ProjectFVBtn.enabled = false
        _NyxBtn.enabled = false

        let doc = Application.instance().document

        doc.clear()

        let proj = VpProject( document: doc )

        if let url = NSBundle.mainBundle().URLForResource(  "diagrams",
                                                            withExtension: "xml",
                                                            subdirectory: "EmbeddedRes/diagrams/ProjectFV") {
            proj.load(url)
            doc.filesPathRoot = "EmbeddedRes/CodeSite/ProjectFV/"
            doc.projectName = "ProjectFV"
        }

        Application.instance().actionsBus.send( OpenStoryAction(story: MethodSelectionStory(), sender: self))
    }
    
    @IBAction func onNyxSelected(sender: AnyObject) {

        _ProjectFVBtn.enabled = false
        _NyxBtn.enabled = false

        let doc = Application.instance().document

        doc.clear()

        let proj = VpProject( document: doc )

        if let url = NSBundle.mainBundle().URLForResource(  "diagrams",
                                                            withExtension: "xml",
                                                            subdirectory: "EmbeddedRes/diagrams/Nyx") {
            proj.load(url)
            doc.filesPathRoot = "EmbeddedRes/CodeSite/Nyx/"
            doc.projectName = "Nyx"
        }

        Application.instance().actionsBus.send( OpenStoryAction(story: MethodSelectionStory(), sender: self))
    }
    
    @IBOutlet weak var _ProjectFVBtn: UIButton!
    @IBOutlet weak var _NyxBtn: UIButton!
}
