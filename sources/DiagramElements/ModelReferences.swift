//
// Created by Danny Thibaudeau on 15-08-29.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class ModelReferences {

    public func add(ref: ModelReference) {
        _refs[ref.diagramOrigin] = ref

        if _refs.count == 1 {
            _defRef = ref
        }
        else {

            if let r = _defRef where r.diagramId != ref.diagramId {
                _defRef = nil
            }
        }
    }

    public func getForParentDiagram(origin: String) -> ModelReference! {

        if let ref = _defRef {
            return ref
        }

        return _refs[origin]
    }

    var _refs : [String:ModelReference] = [:]
    var _defRef : ModelReference! = nil
}
