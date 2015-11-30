//
//  FileViewStory.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-21.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import DiagramElements

class FileViewStory : Story {

    override var type: StoryType {
        get {
            return .Modal
        }
    }

    override var view: UIView {
        get {
            return _controller.view
        }
    }
    
    init(file: String) {
        
        super.init()

        var fileParts = file.componentsSeparatedByString("/")
        let lastFilePart = fileParts.removeLast()
        let filenameParts = lastFilePart.componentsSeparatedByString(".")
        
        var filePath = ""
        
        for s in fileParts {
            filePath += "\(s)/"
        }
        
        if let fileURL = NSBundle.mainBundle().URLForResource(filenameParts[0], withExtension: filenameParts[1], subdirectory: filePath) {
            
            debugPrint(fileURL)
            _controller = FileViewController(fileURL: fileURL)
            _controller.backEventHandler = onBack
        }

//        let app = Application.instance();
//        if let  question = app.searchQuestion,
//                rootPath = app.document.filesPathRoot,
//                questionFile = question.file {
//
//            let questionFilePath = rootPath + questionFile
//            if questionFilePath == file {
//                debugPrint("item found")
//            }
//        }

    }
    
    func onBack(sender: AnyObject, args: [String: AnyObject]!) {
        debugPrint("onBack story handler")
        Application.instance().actionsBus.send( CloseStoryAction(story: self, sender: self) )
    }

    var _controller : FileViewController!
}
