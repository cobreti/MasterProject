//
//  DiagramLayers.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-01.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation


public class Diagrams {

    
    public func add( layer : Diagram ) {
        _layers[layer.name] = layer
    }
    
    public func get( name : String ) -> Diagram! {
        return _layers[name]
    }
    
    public func list() -> [String] {
        
        var list : [String] = []
        
        for (name, obj) in _layers {
            list.append(name)
        }
        
        return list
    }

    public func clear() {
        _layers.removeAll(keepCapacity: false)
    }
    
    var _layers : [String : Diagram] = [:]
}
