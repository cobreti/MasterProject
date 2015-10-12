//
// Created by Danny Thibaudeau on 15-08-15.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class DisplayGraphItem {

    var id : String! {
        get {
            return _id
        }
        set (value) {
            _id = value
        }
    }

    func draw(  params: DisplayGraphDrawParams ) {

    }

    var _id : String!
}
