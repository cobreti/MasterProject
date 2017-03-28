//
//  XmlElementParser.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-10.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements

var g_xmlParserIndent = 0

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
    
    func onGlobalStartElement( _ elementName : String,
        namespaceURI : String?,
        qualifiedName : String?,
        attributeDict : [AnyHashable: Any]) {
            
    }
    
    func onGlobalEndElement(  _ elementName : String,
        namespaceURI : String?,
        qualifiedName : String? ) {
            
        if elementName == _name {
            onElementParsingCompleted()
        }
    }
    
    func onElementParsingStarting(  _ elementName : String,
                                    namespaceURI : String?,
                                    qualifiedName : String?,
                                    attributeDict : [AnyHashable: Any]) {
            
        var indent = ""
        for idx in 0 ..< g_xmlParserIndent {
            indent += "  "
        }

        var id = ""
                                        
        if let attrId = attributeDict["id"] as? String {
            id = attrId
        }
                                        
//        debugPrint(">\(indent)\(elementName) - \(id)")

        g_xmlParserIndent += 1
    }
    
    func onElementParsingCompleted() {
        
        g_xmlParserIndent -= 1
        
        if let delegate = self.delegate {
            delegate.onParsingCompleted(self)
        }
    }
    
    var _name : String
    var _delegate : XmlElementParserDelegate!
}

