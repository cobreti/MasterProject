//
//  ModelsTable.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-20.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class ModelsTable {
    
    public init() {
        
    }
    
    public func add( model : Model ) {
        
        _models[model.id] = model
    }
    
    public func get( id : String ) -> Model! {
        
        if let m = _models[id] {
            return _models[id]
        }
        
        for (childId, childModel) in _models {
            
//            debugPrintln("looking for id \(id) in \(childId)")
            
            if let m = childModel.children.get(id) {
                return m
            }
        }
        
        return nil
    }
        
    private var _models : [String : Model] = [:]
}
