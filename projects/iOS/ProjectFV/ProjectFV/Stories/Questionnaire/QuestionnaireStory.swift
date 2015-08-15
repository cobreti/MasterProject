//
// Created by Danny Thibaudeau on 15-07-18.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import VpProject
import DiagramElements


class QuestionnaireStory : Story {

    override var view: UIView! {
        get {
            return _controller.view
        }
    }


    override init() {

        _document = DiagramElements.Document()

        super.init()

//        _controller = QuestionnaireViewController(nibName: "Questionnaire", bundle: nil)

        loadDiagrams()

        _controller = QuestionnaireViewController(document: _document)
    }

    func loadDiagrams() {

        var vpProj = VpProject(document: _document)

        if let url = NSBundle.mainBundle().URLForResource("diagrams",
                                                          withExtension: "xml",
                                                          subdirectory: "EmbeddedRes/diagrams/Questionnaire") {

            vpProj.load(url)
        }
    }

    var _controller : QuestionnaireViewController!
    var _document : DiagramElements.Document
}
