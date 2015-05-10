//
//  AnchorAreas.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-09.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes

public class AnchorAreas {
    
    public init() {
        
    }
    
    public func add( id : String, area : AnchorArea ) {
        _areas[id] = area
    }
    
    public func getAreaContainedInRect( rc : Rect ) -> AnchorArea! {
        
        for (id, area) in _areas {
            if rc.contains(area.box) {
                return area
            }
        }
        
        return nil
    }
    
    private var _areas : [String : AnchorArea] = [ : ]
}
