//
//  DiagramLayers.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-01.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation


open class Diagrams {

    
    open func add( _ layer : Diagram ) {
        _layers[layer.name] = layer
    }
    
    open func get( _ name : String ) -> Diagram! {
        return _layers[name]
    }
    
    open func list() -> [String] {
        
        var list : [String] = []
        
        for (name, _) in _layers {
            list.append(name)
        }
        
        return list
    }

    open func clear() {
        _layers.removeAll(keepingCapacity: false)
    }
    
    var _layers : [String : Diagram] = [:]
}
