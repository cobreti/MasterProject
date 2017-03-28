//
// Created by Danny Thibaudeau on 2016-01-02.
// Copyright (c) 2016 Danny Thibaudeau. All rights reserved.
//

import Foundation

class NavigationHistory {

    init() {

    }

    var currentGroup : NavigationItemsGroup! {
        get {
            return _history[_history.count-1]
        }
    }

    func add( _ diagramName : String ) -> NavigationItemsGroup {

        let group = NavigationItemsGroup(diagramName: diagramName)
        _history.append( group )
        return group
    }

    func removeCurrentGroup() {
        _history.removeLast()
    }

    var _history: [NavigationItemsGroup] = []
}
