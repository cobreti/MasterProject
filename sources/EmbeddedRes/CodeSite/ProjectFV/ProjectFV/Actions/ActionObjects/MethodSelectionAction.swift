//
// Created by Danny Thibaudeau on 15-08-02.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class MethodSelectionAction : Action {

    override var description: String {
        return "method selected : \(_method.rawValue)"
    }

    var method: MethodType {
        get {
            return _method
        }
    }

    init( method: MethodType, sender: AnyObject!) {

        _method = method

        super.init(id: .MethodSelection, sender: sender)
    }

    var _method : MethodType
}
