//
//  FileViewAction.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-14.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class FileViewAction : Action {
    
    var file : String {
        get {
            return _file
        }
    }
    
    override var description : String {
        get {
            return "viewing file : \(file)"
        }
    }
    
    init(file: String, sender: AnyObject) {
        
        _file = file
        
        super.init(id: .FileView, sender: sender)
    }
    
    var _file : String
}