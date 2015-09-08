//
//  FileReference.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-09-07.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class FileReference {
    
    public var path: String {
        get {
            return _path
        }
    }
    
    public var diagramOrigin: String {
        get {
            return _diagramOrigin
        }
    }
    
    public init(path: String, origin: String) {
        
        _path = path
        _diagramOrigin = origin
    }

    var _path : String
    var _diagramOrigin : String
}