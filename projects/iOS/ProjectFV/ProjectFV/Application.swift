//
//  Application.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-15.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements
import VpProject

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
    
    var actionsBus : ActionsBus {
        get {
            return _actionsBus!
        }
    }
    
    var document : DiagramElements.Document {
        get {
            return _document
        }
    }
    
    func loadDiagrams() {
    
        var proj = VpProject( document: _document )
        
        if let url = NSBundle.mainBundle().URLForResource(  "ProjectFV",
                                                            withExtension: "xml",
                                                            subdirectory: "EmbeddedRes/diagrams") {
            proj.load(url)
            _document.filesPathRoot = "EmbeddedRes/CodeSite/ProjectFV/"
        }
    }
    
    func finishedLaunching() {
    
        loadDiagrams()
    
        _actionsBus = ActionsBus()
        _storiesMgr = StoriesMgr()
        
        _actionsBus.listeners.add(_storiesMgr)
  
//        stories.push( FileViewStory(file: "EmbeddedRes/CodeSite/ProjectFV/DiagramElements/DiagramLayer.swift") )
        stories.push( DiagramSelectionStory() )
    }
    
    var _document : DiagramElements.Document = DiagramElements.Document()
    var _mainViewController : UIViewController!
    var _storiesMgr : StoriesMgr!
    var _actionsBus : ActionsBus!
}

