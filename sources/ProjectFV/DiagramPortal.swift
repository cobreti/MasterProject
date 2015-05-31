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
    
    var scalingFactor : Double {
        get {
            return _scaling
        }
    }
    
    var translation : Point {
        get {
            return _translation
        }
        set (value) {
            _translation = value
        }
    }
    
    var pinPoint : PinPoint {
        get {
            return _pinPoint
        }
        set (value) {
            _pinPoint = value
        }
    }
    
    var boundingBox : Rect {
        get {
            return rectFromDiagramToPortal(_boundingBox)
        }
    }
    
    init( rcArea : Rect, diagramBox : Rect ) {
        
        _area = rcArea
        _diagramBox = diagramBox
        _offset = Point(x: -diagramBox.pos.x, y: -diagramBox.pos.y)
        _boundingBox = diagramBox
        _translation = Point(x: 0, y: 0)
        
        _pinPoint = PinPoint(x: _diagramBox.midX, y: _diagramBox.midY)
        updateScaling()
    }
    
    func alignWithViewPinPoint( viewPinPoint: PinPoint ) {
        
        var portalPinPoint : Point = pointFromDiagramToPortal(_pinPoint)
        
//        _translation.x = (viewPinPoint.x - portalPinPoint.x)
//        _translation.y = (viewPinPoint.y - portalPinPoint.y)
    }
    
    func updateScaling() {
        
        let scalingX = (_area.size.width - _margins.left - _margins.right) / _diagramBox.size.width
        let scalingY = (_area.size.height - _margins.top - _margins.bottom) / _diagramBox.size.height
        
        _scaling = min(scalingX, scalingY)
        let dx = _area.size.width - _margins.left - _margins.right - _scaling * _diagramBox.size.width
        let dy = _area.size.height - _margins.top - _margins.bottom - _scaling * _diagramBox.size.height
        
        debugPrintln("scalingX = \(scalingX), scalingY = \(scalingY)")
        debugPrintln("dx = \(dx)   dy = \(dy)")
    }
    
    func rectFromDiagramToPortal( rc : Rect ) -> Rect {
        
        return Rect(
            x: (rc.left + _translation.x + _offset.x) * _scaling * _zoom + _margins.left,
            y: (rc.top + _translation.y + _offset.y) * _scaling * _zoom + _margins.top ,
            width: rc.size.width * _scaling * _zoom,
            height: rc.size.height * _scaling * _zoom )
    }
    
    func PointFromViewToPortal( pt: Point ) -> Point {
        return Point(
            x: pt.x - _margins.left - _translation.x + _offset.x,
            y: pt.y - _margins.top - _translation.y + _offset.y
        )
    }
    
    func PointFromPortalToDiagram( pt: Point ) -> Point {
        return Point(
            x: (pt.x - _margins.left - _translation.x) / (_zoom * _scaling) - _offset.x,
            y: (pt.y - _margins.top - _translation.y) / (_zoom * _scaling) - _offset.y
        )
    }
    
    func pointFromDiagramToPortal( pt : Point ) -> Point {
        
        return Point(
            x: (pt.x + _offset.x) * _scaling * _zoom + _margins.left + _translation.x,
            y: (pt.y + _offset.y) * _scaling * _zoom + _margins.top + _translation.y )
    }
    
    private var _area : Rect
    private var _diagramBox : Rect
    private var _boundingBox : Rect
    private var _margins : Margins = Margins(left: 10, top: 10, right: 10, bottom: 10)
    private var _offset : Point
    private var _scaling : Double = 1.0
    
    private var _zoom : Double = 1.0
    private var _translation : Point
    private var _pinPoint : PinPoint
}

