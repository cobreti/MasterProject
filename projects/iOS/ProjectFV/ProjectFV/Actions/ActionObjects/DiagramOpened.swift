//
// Created by Danny Thibaudeau on 2016-01-04.
// Copyright (c) 2016 Danny Thibaudeau. All rights reserved.
//

import Foundation

class DiagramOpened : Action {

    var diagramName : String {
        get {
            return _diagramName
        }
    }

    var modelId : String {
        get {
            return _modelId
        }
    }

    override var description : String {
        get {
            return "diagram opened : \(_diagramName) using modelId : \(_modelId) [name = \(_modelName)]"
        }
    }


    init(diagramName: String, modelName: String, modelId: String, sender: AnyObject! ) {

        _diagramName = diagramName
        _modelName = modelName
        _modelId = modelId

        super.init(id: ActionIdentifier.DiagramOpened, sender: sender)

    }

    var _diagramName : String
    var _modelName: String
    var _modelId : String
}
