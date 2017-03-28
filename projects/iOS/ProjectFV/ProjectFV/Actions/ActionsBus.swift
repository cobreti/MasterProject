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
    
    func send( _ action: Action ) {
        
        
        if action.log {
            debugPrint(action.traceline)
            writeToLog(action.traceline)
        }
        _listeners.send(action)
    }
    
    func writeToLog(_ text: String) {
        
        let file = "actions_log_\(_timestamp).txt"
        let textLine = text
        let data = textLine.data(using: String.Encoding.utf8, allowLossyConversion: false)!

        
        let dirs : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        let dir = URL(fileURLWithPath: dirs[0]) //documents directory
        let path = dir.appendingPathComponent(file);
        let fileURL = path
        
        do {
            let  fileHandle = try FileHandle(forWritingTo: fileURL)
            
            fileHandle.seekToEndOfFile()
            fileHandle.write(data)
            fileHandle.closeFile()
        }
        catch _ {
            do {
                
                try textLine.write(toFile: path.path, atomically: false, encoding: String.Encoding.utf8);
            }
            catch _ {
                debugPrint("failure to write to file")
            }
        }
    }
    
    fileprivate var _listeners : ActionListeners
    fileprivate let _timestamp : Date = Date()
}
