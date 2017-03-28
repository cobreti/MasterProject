//
//  Story.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-01.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

typealias EventHandler = (_ sender : AnyObject, _ args: [String : AnyObject]?) -> Void

class Story {

    var type : StoryType {
        get {
            return StoryType.default
        }
    }
    
    var view : UIView! {
        get {
            return nil
        }
    }

    var toolbar : UIView! {
        get {
            return nil
        }
    }

    var backEnabled : Bool {
        get {
            return true
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

    func onActivate() {

    }

    func onDeactivate() {

    }
    
    func onAction(_ action: Action) {
        
    }
    
    var _ownerStoriesMgr : StoriesMgr!
}
