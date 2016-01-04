//
// Created by Danny Thibaudeau on 2016-01-02.
// Copyright (c) 2016 Danny Thibaudeau. All rights reserved.
//

import Foundation

class NavigationHistory {

    init() {

    }

    func add( diagramName : String, modelId : String ) {

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
