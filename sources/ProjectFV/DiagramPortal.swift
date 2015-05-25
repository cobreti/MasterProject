//
//  DiagramPortal.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-18.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes

class DiagramPortal {
    
    var viewRect : Rect {
        get {
            return _area
        }
        set (value) {
            _area = value
            updateScaling()
        }
    }
    
    var zoom : Double {
        get {
            return _zoom
        }
        set (value) {
            _zoom = value
        }
    }
    
    init( rcArea : Rect, diagramBox : Rect ) {
        
        _area = rcArea
        _diagramBox = diagramBox
        _offset = Point(x: -diagramBox.pos.x, y: -diagramBox.pos.y)

        updateScaling()
    }
    
    func updateScaling() {
        
        let scalingX = (_area.size.width - _margins.left - _margins.right) / _diagramBox.size.width
        let scalingY = (_area.size.height - _margins.top - _margins.bottom) / _diagramBox.size.height
        
        _scaling = min(scalingX, scalingY)
    }
    
    func rectFromDiagramToPortal( rc : Rect ) -> Rect {
        
        return Rect(
            x: (rc.left + _offset.x) * _scaling * _zoom + _margins.left,
            y: (rc.top + _offset.y) * _scaling * _zoom + _margins.top,
            width: rc.size.width * _scaling * _zoom,
            height: rc.size.height * _scaling * _zoom )
    }
    
    func pointFromDiagramToPortal( pt : Point ) -> Point {
        
        return Point(
            x: (pt.x + _offset.x) * _scaling * _zoom + _margins.left,
            y: (pt.y + _offset.y) * _scaling * _zoom + _margins.top )
    }
    
    private var _area : Rect
    private var _diagramBox : Rect
    private var _margins : Margins = Margins(left: 10, top: 10, right: 10, bottom: 10)
    private var _offset : Point
    private var _scaling : Double = 1.0
    private var _zoom : Double = 1.0
}

