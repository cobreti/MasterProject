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
    
    var document : DiagramElements.Document {
        get {
            return _document
        }
    }
    
    func finishedLaunching() {
        
        if let wnd = UIApplication.sharedApplication().keyWindow {
        
            for view in wnd.subviews {
                view.removeFromSuperview();
            }
        
            _mainViewController = DiagramViewController(nibName: "DiagramView", bundle: nil)
            wnd.addSubview(_mainViewController.view)
            
            _mainViewController.view.frame = wnd.bounds
        }
    }
    
    var _document : DiagramElements.Document = DiagramElements.Document()
    var _mainViewController : DiagramViewController!
}

