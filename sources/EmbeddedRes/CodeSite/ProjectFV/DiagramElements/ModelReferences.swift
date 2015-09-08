//
// Created by Danny Thibaudeau on 15-08-29.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

public class ModelReferences {

    public func add(ref: ModelReference) {
        _refs[ref.diagramOrigin] = ref
    }

    public func getForParentDiagram(origin: String) -> ModelReference! {
        return _refs[origin]
    }

    var _refs : [String:ModelReference] = [:]
}
