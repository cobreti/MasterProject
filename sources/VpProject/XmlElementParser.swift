//
//  XmlElementParser.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-10.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements

class XmlElementParser {
    
    var name : String {
        get {
            return _name
        }
    }

    var docParser : XmlDocParser {
        get {
            return _docParser
        }
    }

    var currentDiagram : DiagramLayer! {
        get {
            return docParser.currentDiagram
        }
    }

    var document : DiagramElements.Document! {
        get {
            return docParser.document
        }
    }
    
    init( name : String, docParser : XmlDocParser ) {
        _docParser = docParser
        _name = name
    }

    func onStartElement(    elementName : String,
                            namespaceURI : String?,
                            qualifiedName : String?,
                            attributeDict : [NSObject:AnyObject]) {
            
    }

    func onEndElement(  elementName : String,
                        namespaceURI : String?,
                        qualifiedName : String? ) {

        if elementName == _name {
            Stop()
        }
                            
    }

    func Stop() {
        docParser.popElementParser(self)
    }

    var _docParser : XmlDocParser
    var _name : String
}

