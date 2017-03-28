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

    var fileURL : URL! {
        get {

            if let file = self.file {
                
                let f: String = Application.instance().document.filesPathRoot + file
                var fileParts = f.components(separatedBy: "/")
                let lastFilePart = fileParts.removeLast()
                let filenameParts = lastFilePart.components(separatedBy: ".")

                var filePath = ""

                for s in fileParts {
                    filePath += "\(s)/"
                }

                if let url = Bundle.main.url(forResource: filenameParts[0], withExtension: filenameParts[1], subdirectory: filePath) {
                    return url
                }
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

