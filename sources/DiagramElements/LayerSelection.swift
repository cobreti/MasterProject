//
//  LayerSelection.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-07.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class LayerSelection {

    public init() {
        
    }
    
    public func add(item: Primitive) {
        
        _items[item.uuid] = item
    }
    
    public func remove(item: Primitive) {
        _items.removeValueForKey(item.uuid)
    }
    
    public func clear() {
        _items.removeAll(keepCapacity: true)
    }
    
    public func isSelected(item : Primitive) -> Bool {
        return _items.indexForKey(item.uuid) != nil
    }
    
    var _items : [NSUUID:Primitive] = [:]
}
