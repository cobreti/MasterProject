//
// Created by Danny Thibaudeau on 15-05-01.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements

open class VpProject {

    public init( document : DiagramElements.Document! = nil ) {

        if let doc = document {
            _document = doc
        }
        else {
            _document = DiagramElements.Document()
        }
    }

    open func load( _ url : URL ) {

        let parser = XmlDocParser(doc: _document)
        parser.parse(url)
    }

    var _document : DiagramElements.Document
}
