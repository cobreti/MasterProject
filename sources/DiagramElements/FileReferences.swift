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

        if _refs.count == 1 {
            _defRef = ref
        }
        else {

            if let r = _defRef where r.path != ref.path {
                _defRef = nil
            }
        }
    }
    
    public func getForParentDiagram(origin: String) -> FileReference! {

        if let ref = _defRef {
            return ref
        }

        return _refs[origin]
    }

    var _refs : [String:FileReference] = [:]
    var _defRef : FileReference! = nil
}

