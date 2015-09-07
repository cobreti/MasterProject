//
//  OpenStory.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-13.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class OpenStoryAction : Action {
    
    var story: Story {
        get {
            return _story
        }
    }
    
    override var description : String {
        get {
            return "opening story \(_story.dynamicType)"
        }
    }
    
    init(story: Story, sender: AnyObject!) {
        
        _story = story
        
        super.init(id: .OpenStory, sender: sender)
    }
    
    var _story : Story
}