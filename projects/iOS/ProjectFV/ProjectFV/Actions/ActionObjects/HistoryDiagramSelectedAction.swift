//
// Created by Danny Thibaudeau on 15-07-16.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class HistoryDiagramSelectedAction: Action {

    var diagramController: DiagramViewController {
        get {
            return _diagramController
        }
    }

    override var description: String {
        get {
            return "diagram name : \(_diagramController.diagram.name)"
        }
    }


    init(controller: DiagramViewController, sender: AnyObject!) {

        _diagramController = controller

        super.init(id: .HistoryDiagramSelected, sender: nil)
    }

    var _diagramController : DiagramViewController
}
