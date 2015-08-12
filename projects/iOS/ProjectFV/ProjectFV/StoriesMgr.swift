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
    
    func pop() {

        if let lastStory = _stories.last {
            
            lastStory.view?.removeFromSuperview()
            _stories.removeLast()
            lastStory.ownerStoriesMgr = nil
        }
    }
    
    func onAction(action: Action) {
        
        switch action.id {
            
            case .CloseStory:
                pop()
            
            case .OpenStory:
                if let osa = action as? OpenStoryAction {
                    push(osa.story)
                }

            case .Restart:
                _stories.removeAll(keepCapacity: false)
                Application.instance().actionsBus.send( OpenStoryAction(story: QuestionnaireStory(), sender: self))

            default:
                _stories.last?.onAction(action)
        }
    }
 
    var _stories : [Story] = []
}

