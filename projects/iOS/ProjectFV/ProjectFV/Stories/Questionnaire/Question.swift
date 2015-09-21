//
// Created by Danny Thibaudeau on 15-09-20.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class Question {

    var question : String {
        get {
            return _question
        }
    }

    var answerCount : Int {
        get {
            return _answers.count
        }
    }

    init(question: String) {
        _question = question
    }

    func add( choice : AnswerChoice ) {
        _answers.append(choice)
    }

    func get( index: Int ) -> String {
        return _answers[index].text
    }

    var _question: String
    var _answers : [AnswerChoice] = []
}
