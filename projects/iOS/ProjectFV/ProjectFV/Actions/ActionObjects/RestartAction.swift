//
// Created by Danny Thibaudeau on 15-08-12.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class RestartAction : Action {

    override var description: String {
        get {
            return "Restart"
        }
    }


    init(sender: AnyObject!) {
        super.init(id: .Restart, sender: sender)
    }
}
