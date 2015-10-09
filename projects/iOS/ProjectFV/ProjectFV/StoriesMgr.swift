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

        _stories.append(story)
        story.ownerStoriesMgr = self

        activateStory(story)
//        if let wnd = UIApplication.sharedApplication().keyWindow {
//
//            story.ownerStoriesMgr = self
//
//            activateStory(story)
//        }
//
//        _controller.enableBackButton( _stories.count > 1 )
    }
    
    func pop() {

        if let lastStory = _stories.last {

            lastStory.onDeactivate()
            lastStory.view?.removeFromSuperview()
            _stories.removeLast()
            lastStory.ownerStoriesMgr = nil
        }

        if let currentStory = _stories.last {

            activateStory(currentStory)
        }

//        _controller.enableBackButton( _stories.count > 1 )
    }

    func activateStory(story: Story) {

        switch story.type {

            case .Default:
                _controller.setStoryView(story.view)
                _controller.setStoryTB(story.toolbar)
                story.onActivate()
                _controller.enableBackButton( _stories.count > 1 && story.backEnabled)

            case .Modal:
                _controller.setModalStoryView(story.view)
        }
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

