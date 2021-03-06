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

    func add( _ choice : AnswerChoice ) {
        _answers.append(choice)
    }

    func get( _ index: Int ) -> AnswerChoice {
        return _answers[index]
    }

    var _question: String
    var _answers : [AnswerChoice] = []
}
