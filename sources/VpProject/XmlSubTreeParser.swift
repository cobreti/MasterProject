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

    override func onStartElement(   elementName : String,
                                    namespaceURI : String?,
                                    qualifiedName : String?,
                                    attributeDict : [NSObject:AnyObject]) {
            
        if let p = currentParser {
            p.onStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
        }
    }
    
    override func onEndElement( elementName : String,
                                namespaceURI : String?,
                                qualifiedName : String? ) {

        super.onEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName)
            
        if let p = currentParser {
            p.onEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName)
        }
    }

    func onParsingCompleted( elmParser : XmlElementParser ) {
        
        popElementParser(elmParser)
    }
    
    func pushElementParser( parser : XmlElementParser ) {
        _elementParsers.append(parser)
    }
    
    func popElementParser( parser : XmlElementParser ) {
        _elementParsers.removeLast()
    }
    
    var _elementParsers : [XmlElementParser] = []
}
