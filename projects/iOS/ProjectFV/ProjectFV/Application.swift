//
//  Application.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-15.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements

var g_app : Application!

class Application {
    
    class func instance() -> Application {
        
        if let app = g_app {
            return app
        }
        
        g_app = Application()
        return g_app!
    }
    
    
    var stories : StoriesMgr {
        get {
            return _storiesMgr!
        }
    }
    
    var document : DiagramElements.Document {
        get {
            return _document
        }
    }
    
    func finishedLaunching() {
        
        _storiesMgr = StoriesMgr()
        
        stories.push( SchematicViewStory(diagramName: "VpProject") )
    }
    
    var _document : DiagramElements.Document = DiagramElements.Document()
    var _mainViewController : DiagramViewController!
    var _storiesMgr : StoriesMgr!
}

