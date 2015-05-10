//
//  AnchorArea.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-09.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class AnchorArea {
    
    public init( x : CGFloat, y : CGFloat, width : CGFloat, height : CGFloat ) {
        
        _x = x
        _y = y
        _width = width
        _height = height
    }
    
    private var _x : CGFloat = 0
    private var _y : CGFloat = 0
    private var _width : CGFloat = 0
    private var _height : CGFloat = 0
}