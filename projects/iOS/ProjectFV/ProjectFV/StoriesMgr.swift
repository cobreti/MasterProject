//
//  StoriesMgr.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-01.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class StoriesMgr {
 
    
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
            wnd.addSubview(story.view)
            story.view.frame = wnd.bounds
        }
    }
 
    var _stories : [Story] = []
}
