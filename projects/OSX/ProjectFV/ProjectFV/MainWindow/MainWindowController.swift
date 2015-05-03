//
//  MainWindowController.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-03.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import AppKit

class MainWindowController : NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        if let wnd = window as? MainWindow {
            _diagramViewController = DiagramViewController(nibName: "DiagramView", bundle: nil )
            wnd._diagramViewContainer.addSubview(_diagramViewController.view)
            
            var subviewFrame = NSMakeRect(0, 0, wnd._diagramViewContainer.bounds.width, wnd._diagramViewContainer.bounds.height)
            _diagramViewController.view.frame = subviewFrame
        }
        
    }
    
    var _diagramViewController : DiagramViewController!
}
