//
//  FileReferences.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-09-07.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

open class FileReferences {

    open var empty : Bool  {
        get {
            return _refs.count == 0
        }
    }
    
    open func add(_ ref: FileReference) {

        _refs[ref.diagramOrigin] = ref

        if _refs.count == 1 {
            _defRef = ref
        }
        else {

            if let r = _defRef, r.path != ref.path {
                _defRef = nil
            }
        }
    }
    
    open func getForParentDiagram(_ origin: String!) -> FileReference! {

        if let ref = _defRef {
            return ref
        }

        if let org = origin {
            return _refs[org]
        }

        return nil
    }

    var _refs : [String:FileReference] = [:]
    var _defRef : FileReference! = nil
}

