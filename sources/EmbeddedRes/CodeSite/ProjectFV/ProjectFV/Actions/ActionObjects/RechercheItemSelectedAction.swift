//
// Created by Danny Thibaudeau on 15-07-26.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class RechercheItemSelectedAction : Action {

    override var description: String {
        return "recherche item selectionne : \(_title)  --- \(_question)"
    }

    init(title: String, question: String, sender: AnyObject!) {

        _title = title
        _question = question
        super.init(id: .RechercheItemSelected, sender: sender)
    }

    var _question: String
    var _title: String
}
