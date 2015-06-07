//
//  DiagramLayers.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-01.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation


public class DiagramLayers {

    
    public func add( layer : DiagramLayer ) {
        _layers[layer.name] = layer
    }
    
    public func get( name : String ) -> DiagramLayer! {
        return _layers[name]
    }
    
    public func list() -> [String] {
        
        var list : [String] = []
        
        for (name, obj) in _layers {
            list.append(name)
        }
        
        return list
    }
    
    var _layers : [String : DiagramLayer] = [:]
}
