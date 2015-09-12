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

        _controller = StoriesBoardController(nibName: "StoriesBoard", bundle: nil)
    }
    
    func push( story : Story ) {
        
        if let wnd = UIApplication.sharedApplication().keyWindow {
        
            _stories.append(story)
            story.ownerStoriesMgr = self

            _controller.setStoryView(story.view)
            story.onActivate()
        }

        _controller.enableBackButton( _stories.count > 1 )
    }
    
    func pop() {

        if let lastStory = _stories.last {

            lastStory.onDeactivate()
            lastStory.view?.removeFromSuperview()
            _stories.removeLast()
            lastStory.ownerStoriesMgr = nil
        }

        if let currentStory = _stories.last {

            _controller.setStoryView(currentStory.view)
            currentStory.onActivate()
        }

        _controller.enableBackButton( _stories.count > 1 )
    }

    func onWindowReady(viewContainer: UIView) {

        viewContainer.addSubview(_controller.view)
        _controller.view.frame = viewContainer.bounds

        _controller.enableBackButton(false)
    }

    func closeCurrentStory() {

        if let story = _stories.last {

            Application.instance().actionsBus.send( CloseStoryAction(story: story, sender: self) )
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
    var _controller : StoriesBoardController
}

