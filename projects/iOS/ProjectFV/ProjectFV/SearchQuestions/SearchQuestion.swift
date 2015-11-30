//
// Created by Danny Thibaudeau on 15-09-27.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class SearchQuestion {

    var title: String {
        get {
            return _title
        }
    }

    var content: String {
        get {
            return _content
        }
    }

    var file : String! {
        get {
            return _file
        }
        set (value) {
            _file = value
        }
    }

    var fileURL : NSURL! {
        get {
            var f : String = Application.instance().document.filesPathRoot + file
            var fileParts = f.componentsSeparatedByString("/")
            let lastFilePart = fileParts.removeLast()
            let filenameParts = lastFilePart.componentsSeparatedByString(".")

            var filePath = ""

            for s in fileParts {
                filePath += "\(s)/"
            }

            if let url = NSBundle.mainBundle().URLForResource(filenameParts[0], withExtension: filenameParts[1], subdirectory: filePath) {
                return url
            }

            return nil
        }
    }

    init(title: String, content:String) {
        _title = title
        _content = content
    }

    var _title: String
    var _content: String
    var _file : String!
}

