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
        
        _controller = DiagramSelectionController(nibName: "DiagramSelection", bundle: nil)
    }
    
    var _controller : DiagramSelectionController!
}
