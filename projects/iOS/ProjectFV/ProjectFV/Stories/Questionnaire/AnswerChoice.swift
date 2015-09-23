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

    var useOtherField : Bool {
        get {
            return _useOtherField
        }
    }

    init(key: String, text: String, useOtherField: Bool = false) {
        _key = key
        _text = text
        _useOtherField = useOtherField
    }

    var _key : String
    var _text : String
    var _useOtherField : Bool = false
}
