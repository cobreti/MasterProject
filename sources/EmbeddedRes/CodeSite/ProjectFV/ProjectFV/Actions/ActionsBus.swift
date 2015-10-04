//
//  ActionsBus.swift
//  ProjectFV
//
    //  Created by Danny Thibaudeau on 2015-07-11.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class ActionsBus : NSObject {
    
    var listeners : ActionListeners {
        get {
            return _listeners
        }
    }
    
    override init() {
        _listeners = ActionListeners()
        
        super.init()
    }
    
    func send( action: Action ) {
        
        
        if action.log {
            debugPrint(action.traceline)
            writeToLog(action.traceline)
        }
        _listeners.send(action)
    }
    
    func writeToLog(text: String) {
        
        let file = "actions_log_\(_timestamp).txt"
        let textLine = text
        let data = textLine.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!

        
        let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let dir = NSURL(fileURLWithPath: dirs[0]) //documents directory
        let path = dir.URLByAppendingPathComponent(file);
        let fileURL = path
        
        do {
            let  fileHandle = try NSFileHandle(forWritingToURL: fileURL)
            
            fileHandle.seekToEndOfFile()
            fileHandle.writeData(data)
            fileHandle.closeFile()
        }
        catch _ {
            do {
                
                try textLine.writeToFile(path.path!, atomically: false, encoding: NSUTF8StringEncoding);
            }
            catch _ {
                debugPrint("failure to write to file")
            }
        }
    }
    
    private var _listeners : ActionListeners
    private let _timestamp : NSDate = NSDate()
}
