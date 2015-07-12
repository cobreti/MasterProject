//
//  StoriesMgr.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-01.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class StoriesMgr : ActionListener {
 
    
    init() {

        if let wnd = UIApplication.sharedApplication().keyWindow {
            
            for view in wnd.subviews {
                view.removeFromSuperview();
            }
        }
    }
    
    func push( story : Story ) {
        
        if let wnd = UIApplication.sharedApplication().keyWindow {
        
            _stories.append(story)
            story.ownerStoriesMgr = self
            wnd.addSubview(story.view)
            story.view.frame = wnd.bounds
        }
    }
    
    func pop(story: Story) {

        if let lastStory = _stories.last where lastStory === story {
            
            story.view?.removeFromSuperview()
            _stories.removeLast()
            story.ownerStoriesMgr = nil
        }
    }
    
    func onAction(action: Action) {
        
        _stories.last?.onAction(action)
    }
 
    var _stories : [Story] = []
}

