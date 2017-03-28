//
//  SchematicViewStory.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-06.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import DiagramElements

class SchematicViewStory : Story {
    
    override var view : UIView {
        get {
            return _controller.view
        }
    }

    override var toolbar: UIView! {
        get {
            return _controller.toolbar
        }
    }

    override var backEnabled: Bool {
        get {
            return false
        }
    }


    init( diagramName : String) {
        
        _diagramName = diagramName
        let document = Application.instance().document
        
        if let diagram = document.diagrams.get(diagramName) {
            _controller = SchematicViewController(diagram: diagram)
        }

        super.init()
        
//        _controller.diagram = document.diagrams.get(_diagramName)
        _controller._backEventHandler = onBack
    }
    
    func onBack(_ sender: AnyObject, args: [String: AnyObject]!) {
        debugPrint("onBack story handler")
//        Application.instance().actionsBus.send( CloseStoryAction(story: self, sender: self) )
//        ownerStoriesMgr?.pop(self)
    }
    
    override func onAction(_ action: Action) {
        
        _controller.onAction(action)
    }
    
    var _controller : SchematicViewController!
    var _diagramName : String!
}
