//
// Created by Danny Thibaudeau on 2016-01-02.
// Copyright (c) 2016 Danny Thibaudeau. All rights reserved.
//

import Foundation

class NavigationHistory {

    init() {

    }

    var previous: String! {
        get {
            let count = _history.count
            if count > 1 {
                if let item = _history[count-2].item {
                    return item.modelId
                }
            }

            return nil
        }
    }

    var next: String! {
        get {
            let count = _history.count
            if count > 0 {
                if let item = _history[count-2].item {
                    return item.modelId
                }
            }

            return nil
        }
    }

    func add( diagramName : String, modelId : String ) {

        if let g = _history.last where g.diagramName == diagramName {
            g.item = NavigationItem(modelId: modelId)
        }
        else {
            _history.append( NavigationItemsGroup(diagramName: diagramName) )
        }
    }

    func removeItemsWithDiagramName( diagramName: String ) {

        var index = _history.count-1;
        while ( index >= 0 ) {

            let itemGroup = _history[index]

            if itemGroup.diagramName == diagramName {
                _history.removeAtIndex(index)
                break
            }

            --index
        }
    }

    var _history: [NavigationItemsGroup] = []
}
