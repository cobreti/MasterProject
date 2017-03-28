//
// Created by Danny Thibaudeau on 15-08-14.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import VpProject

class ProjectSelectionViewController : UIViewController {

    func onActivated() {

        _ProjectFVBtn.isEnabled = true
        _NyxBtn.isEnabled = true
    }

    @IBAction func onProjectFVSelected(_ sender: AnyObject) {

        _ProjectFVBtn.isEnabled = false
        _NyxBtn.isEnabled = false

        let doc = Application.instance().document

        doc.clear()

        let proj = VpProject( document: doc )

        if let url = Bundle.main.url(  forResource: "diagrams",
                                                            withExtension: "xml",
                                                            subdirectory: "EmbeddedRes/diagrams/ProjectFV") {
            proj.load(url)
            doc.filesPathRoot = "EmbeddedRes/CodeSite/ProjectFV/"
            doc.projectName = "ProjectFV"
        }

        Application.instance().actionsBus.send( OpenStoryAction(story: MethodSelectionStory(), sender: self))
    }
    
    @IBAction func onNyxSelected(_ sender: AnyObject) {

        _ProjectFVBtn.isEnabled = false
        _NyxBtn.isEnabled = false

        let doc = Application.instance().document

        doc.clear()

        let proj = VpProject( document: doc )

        if let url = Bundle.main.url(  forResource: "diagrams",
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
