//
// Created by Danny Thibaudeau on 15-08-16.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import Shapes

class DisplayGraph_EndPoint : DisplayGraphItem {

    init(p1: Point, p2: Point) {
        _p1 = p1
        _p2 = p2
    }

    var _p1 : Point
    var _p2 : Point
}
