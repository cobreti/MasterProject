//
// Created by Danny Thibaudeau on 15-09-20.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class AnswerChoice {

    var key: String {
        get {
            return _key
        }
    }

    var text: String {
        get {
            return _text
        }
    }

    init(key: String, text: String) {
        _key = key
        _text = text
    }

    var _key : String
    var _text : String
}
