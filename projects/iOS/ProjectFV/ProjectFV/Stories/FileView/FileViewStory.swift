//
//  FileViewStory.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-21.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import DiagramElements

class FileViewStory : Story {
    
    override var view: UIView {
        get {
            return _controller.view
        }
    }
    
    override init() {
        
        _controller = FileViewController(nibName: "FileView", bundle: nil)
        
        super.init()
    }
    
    var _controller : FileViewController!
}
