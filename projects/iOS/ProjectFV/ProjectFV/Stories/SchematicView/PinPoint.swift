//
//  PinPoint.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-27.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes

class PinPoint : Shapes.Point {
    
    func ptOfRect( _ rc : Rect ) -> Point {
        
        return Point(x: rc.size.width * self.x + rc.left, y: rc.size.height * self.y + rc.top )
    }
}
