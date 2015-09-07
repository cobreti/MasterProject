//
// Created by Danny Thibaudeau on 15-07-22.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class WriteQuestionAnswerAction : Action {

    override var description: String {
        get {
            return " {\(_question)} -- \(_answer)"
        }
    }

    init( question: String, answer: String, sender: AnyObject! ) {

        _question = question
        _answer = answer

        super.init( id: .WriteQuestionAnswer, sender: sender )
    }

    var _question: String
    var _answer: String
}
