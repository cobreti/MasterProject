//
//  DiagramSelectionStory.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-06.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class DiagramSelectionStory : Story {
    
    override var view : UIView {
        get {
            return _controller.view
        }
    }
    
    override init() {
        
        super.init()
        
        _controller = DiagramSelectionController(nibName: "DiagramSelection", bundle: nil)
    }
    
    override func onAction(_ action: Action) {
        
        switch action.id {
            case .DiagramSelected:
                if let selAction = action as? DiagramSelectedAction {
                    let story = SchematicViewStory(diagramName: selAction.diagramName)
                    Application.instance().actionsBus.send( OpenStoryAction(story: story, sender: self) )
//                    ownerStoriesMgr?.push( SchematicViewStory(diagramName: selAction.diagramName) )
                }
            default:
                break
        }
    }
    
    var _controller : DiagramSelectionController!
}
