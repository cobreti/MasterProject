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
        
        debugPrintln(action.traceline)
        writeToLog(action.traceline)
        _listeners.send(action)
    }
    
    func writeToLog(text: String) {
        
        let file = "actions_log_\(_timestamp).txt"
        let textLine = text
        let data = textLine.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!

        
        if  let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent(file);
            let fileURL = NSURL(fileURLWithPath: path)
            
            if let  fileHandle = NSFileHandle(forWritingToURL: fileURL!, error: nil) {
                    fileHandle.seekToEndOfFile()
                    fileHandle.writeData(data)
                    fileHandle.closeFile()
            }
            else {
                textLine.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding, error: nil);
            }

            }
    }
    
    private var _listeners : ActionListeners
    private let _timestamp : NSDate = NSDate()
}
