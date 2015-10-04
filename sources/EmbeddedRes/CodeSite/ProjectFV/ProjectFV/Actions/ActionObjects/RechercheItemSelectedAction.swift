//
// Created by Danny Thibaudeau on 15-07-26.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class RechercheItemSelectedAction : Action {

    var question: SearchQuestion {
        get {
            return _question
        }
    }

    override var description: String {
        return "recherche item selectionne : \(_question.title)  --- \(_question.content)"
    }

    init(question: SearchQuestion, sender: AnyObject!) {

        _question = question
        super.init(id: .RechercheItemSelected, sender: sender)
    }
    
    var _question : SearchQuestion
}
