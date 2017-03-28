//
// Created by Danny Thibaudeau on 15-08-15.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class DisplayGraphs {

    class var instance: DisplayGraphs {
        get {
            return _instance
        }
    }

    init() {

    }

    func add(_ graph: DisplayGraph) {
        _graphs[graph.name] = graph
    }

    func remove(_ name: String) {
        _graphs.removeValue(forKey: name)
    }

    func get(_ name: String) -> DisplayGraph! {
        return _graphs[name]
    }

    var _graphs : [String:DisplayGraph] = [:]

    static var _instance : DisplayGraphs = DisplayGraphs()
}
