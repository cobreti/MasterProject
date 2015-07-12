//
//  Story.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-01.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

typealias EventHandler = (sender : AnyObject, args: [String : AnyObject]!) -> Void

class Story {
    
    
    var view : UIView! {
        get {
            return nil
        }
    }
    
    var ownerStoriesMgr : StoriesMgr! {
        get {
            return _ownerStoriesMgr
        }
        set (owner) {
            _ownerStoriesMgr = owner
        }
    }
    
    init() {
    }
    
    func onAction(action: Action) {
        
    }
    
    var _ownerStoriesMgr : StoriesMgr!
}
