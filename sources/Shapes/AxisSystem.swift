//
//  AxisSystem.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-24.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class AxisSystem {

    public init( p1 : Point, p2 : Point ) {

        let v1 = Vector2D(x: p2.x - p1.x, y: p2.y - p1.y)
        let v2 = Vector2D(x: v1.y, y: v1.x)

        _xAxis = v1.unitVector
        _yAxis = v2.unitVector
        _origin = p1
    }

    public func fromAxis( p : Point ) -> Point {

        return Point( x: p.x * _xAxis.x + p.y * _xAxis.y + _origin.x, y: p.x * _yAxis.x + p.y * _yAxis.y + _origin.y )
    }

    private var _xAxis : Vector2D
    private var _yAxis : Vector2D
    private var _origin : Point
}

