//
// Created by Danny Thibaudeau on 2016-01-31.
// Copyright (c) 2016 Danny Thibaudeau. All rights reserved.
//

import Foundation

class Step {

    typealias StepFunction = () -> Void

    init( fct: @escaping StepFunction ) {

        _function = fct
    }

    func execute() {
        _function()
    }

    var _function : StepFunction
}
