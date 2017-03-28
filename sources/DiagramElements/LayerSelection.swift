//
//  LayerSelection.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-07.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

open class LayerSelection {

    public init() {
        
    }
    
    open func add(_ item: Primitive) {
        
        _items[item.uuid] = item
    }
    
    open func remove(_ item: Primitive) {
        _items.removeValue(forKey: item.uuid)
    }
    
    open func clear() {
        _items.removeAll(keepingCapacity: true)
    }
    
    open func isSelected(_ item : Primitive) -> Bool {
        return _items.index(forKey: item.uuid) != nil
    }
    
    var _items : [UUID:Primitive] = [:]
}
