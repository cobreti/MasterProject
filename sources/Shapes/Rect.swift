//
//  Rect.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-09.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class Rect {
    
    public class func union(r1 : Rect, r2: Rect) -> Rect {
        
        var x1 = min(r1.left, r2.left)
        var y1 = min(r1.top, r2.top)
        var x2 = max(r1.right, r2.right)
        var y2 = max(r1.bottom, r2.bottom)
        
        return Rect(x: x1, y: y1, width: x2-x1, height: y2-y1)
    }
    
    public var pos : Point {
        get {
            return _pos
        }
    }
    
    public var size : Size {
        get {
            return _size
        }
    }
    
    public var left : Double {
        get {
            return _pos.x
        }
    }
    
    public var top : Double {
        get {
            return _pos.y
        }
    }
    
    public var right : Double {
        get {
            return _pos.x + _size.width
        }
    }
    
    public var bottom : Double {
        get {
            return _pos.y + _size.height
        }
    }
    
    public var midX : Double {
        get {
            return (left + right) / 2
        }
    }
    
    public var midY : Double {
        get {
            return (top + bottom) / 2
        }
    }
    
    public init( x : Double, y : Double, width : Double, height : Double ) {

        _pos = Point(x: x, y: y)
        _size = Size(width: width, height: height)
    }
    
    public convenience init( cgrect : CGRect ) {
        self.init(  x: Double(cgrect.origin.x),
                    y: Double(cgrect.origin.y),
                    width: Double(cgrect.size.width),
                    height: Double(cgrect.size.height) )
    }
    
    public func toCGRect() -> CGRect {
        return CGRect(x: CGFloat(_pos.x), y: CGFloat(_pos.y), width: CGFloat(_size.width), height: CGFloat(_size.height))
    }
    
    public func contains( rc : Rect ) -> Bool {

        return  rc.left >= self.left &&
                rc.right <= self.right &&
                rc.top >= self.top &&
                rc.bottom <= self.bottom
    }

    private var _pos : Point
    private var _size : Size
}
