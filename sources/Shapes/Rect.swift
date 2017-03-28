//
//  Rect.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-09.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

open class Rect {
    
    open class func union(_ r1 : Rect, r2: Rect) -> Rect {
        
        let x1 = min(r1.left, r2.left)
        let y1 = min(r1.top, r2.top)
        let x2 = max(r1.right, r2.right)
        let y2 = max(r1.bottom, r2.bottom)
        
        return Rect(x: x1, y: y1, width: x2-x1, height: y2-y1)
    }
    
    open var pos : Point {
        get {
            return _pos
        }
    }
    
    open var size : Size {
        get {
            return _size
        }
    }
    
    open var left : CGFloat {
        get {
            return _pos.x
        }
    }
    
    open var top : CGFloat {
        get {
            return _pos.y
        }
    }
    
    open var right : CGFloat {
        get {
            return _pos.x + _size.width
        }
    }
    
    open var bottom : CGFloat {
        get {
            return _pos.y + _size.height
        }
    }
    
    open var midX : CGFloat {
        get {
            return (left + right) / 2
        }
    }
    
    open var midY : CGFloat {
        get {
            return (top + bottom) / 2
        }
    }
    
    public init( x : CGFloat, y : CGFloat, width : CGFloat, height : CGFloat ) {

        _pos = Point(x: x, y: y)
        _size = Size(width: width, height: height)
    }
    
    public convenience init( cgrect : CGRect ) {
        self.init(  x: CGFloat(cgrect.origin.x),
                    y: CGFloat(cgrect.origin.y),
                    width: CGFloat(cgrect.size.width),
                    height: CGFloat(cgrect.size.height) )
    }
    
    open func toCGRect() -> CGRect {
        return CGRect(x: CGFloat(_pos.x), y: CGFloat(_pos.y), width: CGFloat(_size.width), height: CGFloat(_size.height))
    }
    
    open func contains( _ rc : Rect ) -> Bool {

        return  rc.left >= self.left &&
                rc.right <= self.right &&
                rc.top >= self.top &&
                rc.bottom <= self.bottom
    }
    
    open func contains(_ pt: Point) -> Bool {
        return pt.x >= self.left && pt.x <= self.right && pt.y >= self.top && pt.y <= self.bottom
    }

    fileprivate var _pos : Point
    fileprivate var _size : Size
}
