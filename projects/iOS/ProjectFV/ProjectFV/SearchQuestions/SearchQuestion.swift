//
// Created by Danny Thibaudeau on 15-09-27.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class SearchQuestion {

    var title: String {
        get {
            return _title
        }
    }

    var content: String {
        get {
            return _content
        }
    }

    init(title: String, content:String) {
        _title = title
        _content = content
    }

    var _title: String
    var _content: String
}

