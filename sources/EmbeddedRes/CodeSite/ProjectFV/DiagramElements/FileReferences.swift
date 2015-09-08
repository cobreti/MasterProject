//
//  FileReferences.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-09-07.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class FileReferences {
    
    public func add(ref: FileReference) {
        _refs[ref.diagramOrigin] = ref
    }
    
    public func getForParentDiagram(origin: String) -> FileReference! {
        return _refs[origin]
    }

    var _refs : [String:FileReference] = [:]
}