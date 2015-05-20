//
//  Model.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-20.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class Model {
    
    public var id : String {
        get {
            return _id
        }
    }
    
    public var children : ModelsTable {
        get {
            return _children
        }
    }
    
    public init(id : String) {
        
        _id = id
    }
    
    
    
    private var _id : String
    private var _children : ModelsTable = ModelsTable()
}