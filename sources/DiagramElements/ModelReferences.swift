//
// Created by Danny Thibaudeau on 15-08-29.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

open class ModelReferences {

    open func add(_ ref: ModelReference) {
        _refs[ref.diagramOrigin] = ref

        if _refs.count == 1 {
            _defRef = ref
        }
        else {

            if let r = _defRef, r.diagramId != ref.diagramId {
                _defRef = nil
            }
        }
    }

    open func getForParentDiagram(_ origin: String) -> ModelReference! {

        if let ref = _defRef {
            return ref
        }

        return _refs[origin]
    }

    var _refs : [String:ModelReference] = [:]
    var _defRef : ModelReference! = nil
}
