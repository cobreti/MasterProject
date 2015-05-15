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

    var delegate : XmlElementParserDelegate! {
        get {
            return _delegate
        }
    }
    
    init( name : String, delegate : XmlElementParserDelegate! = nil) {
        _name = name
        _delegate = delegate
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
            if let delegate = self.delegate {
                delegate.onParsingCompleted(self)
            }
        }
                            
    }

    var _name : String
    var _delegate : XmlElementParserDelegate!
}

