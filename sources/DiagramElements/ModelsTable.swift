//
//  ModelsTable.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-20.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

open class ModelsTable {
    
    public init() {
        
    }
    
    open func add( _ model : Model ) {
        
        _models[model.id] = model
    }
    
    open func get( _ id : String ) -> Model! {
        
        if let _ = _models[id] {
            return _models[id]
        }
        
        for (_, childModel) in _models {
            
//            debugPrintln("looking for id \(id) in \(childId)")
            
            if let m = childModel.children.get(id) {
                return m
            }
        }
        
        return nil
    }

    open func clear() {
        _models.removeAll(keepingCapacity: false)
    }
        
    fileprivate var _models : [String : Model] = [:]
}
