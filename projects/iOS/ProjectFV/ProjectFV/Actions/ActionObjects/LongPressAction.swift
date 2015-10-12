//
// Created by Danny Thibaudeau on 15-10-11.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes

class LongPressAction : GestureAction {

    var pt: Point {
        get {
            return _pt
        }
    }

    override var description: String {
        get {
            return "long press diagram action with state \(state) at : (\(pt.x), \(pt.y))"
        }
    }

    init(pt: Point, state: State, sender: AnyObject) {
        _pt = pt
        super.init(id: .LongPress, state: state, sender: sender)
    }


    var _pt : Point
}
