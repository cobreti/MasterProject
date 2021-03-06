//
//  XmlSubTreeParser.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-15.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class XmlSubTreeParser : XmlElementParser, XmlElementParserDelegate {
    
    
    var currentParser : XmlElementParser! {
        get {
            return _elementParsers.last
        }
    }
    
    override func onGlobalStartElement( _ elementName : String,
                                        namespaceURI : String?,
                                        qualifiedName : String?,
                                        attributeDict : [AnyHashable: Any]) {
        
        _state = XmlParserState(elementName: elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
        
        if let p = currentParser {
            p.onGlobalStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
        }
        else {
            self.onLocalStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
        }
    }
    
    override func onGlobalEndElement(   _ elementName : String,
                                        namespaceURI : String?,
                                        qualifiedName : String? ) {
            
        if elementName == _name && currentParser == nil {
            onElementParsingCompleted()
        }

            
        if let p = currentParser {
            p.onGlobalEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName)
        }
        else {
            self.onLocalEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName)
        }
    }
    

    func onLocalStartElement(   _ elementName : String,
                                namespaceURI : String?,
                                qualifiedName : String?,
                                attributeDict : [AnyHashable: Any]) {
    }

    func onLocalEndElement( _ elementName : String,
                            namespaceURI : String?,
                            qualifiedName : String? ) {
    }
    
    func onParsingCompleted( _ elmParser : XmlElementParser ) {
        
        popElementParser(elmParser)
    }
    
    func pushElementParser( _ parser : XmlElementParser ) {
        _elementParsers.append(parser)
        
        if let state = _state {
            parser.onElementParsingStarting(state.name, namespaceURI: state.namespaceURI, qualifiedName: state.qualifiedName, attributeDict: state.attributeDict)
        }
    }
    
    func popElementParser( _ parser : XmlElementParser ) {
        _elementParsers.removeLast()
    }
    
    var _elementParsers : [XmlElementParser] = []
    var _state : XmlParserState!
}

