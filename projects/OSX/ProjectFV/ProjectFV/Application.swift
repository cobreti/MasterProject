//
// Created by Danny Thibaudeau on 15-05-03.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
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
    
    var document : DiagramElements.Document {
        get {
            return _document
        }
    }
    
    func finishedLaunching() {
        
        _mainWindowController = MainWindowController(windowNibName: "MainWindow")
        _mainWindowController.window?.makeKeyAndOrderFront(nil)
    }
    
    var _document : DiagramElements.Document = DiagramElements.Document()
    var _mainWindowController : MainWindowController!
}

