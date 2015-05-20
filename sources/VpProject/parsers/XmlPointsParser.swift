//
//  XmlPointsParser.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-15.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements

class XmlPointsParser : XmlSubTreeParser {

    init( name : String, link : DiagramElements.Link, delegate: XmlElementParserDelegate ) {
        
        _link = link
        
        super.init(name: name, delegate: delegate)
    }
    
    override func onGlobalStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {
        
        super.onGlobalStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
    }
    
    override func onLocalStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {

        switch elementName {
            case "Point":
                pushElementParser( XmlPointParser(name: "Point", delegate: self) )
                break
            default:
                break
        }
    }
    
    override func onParsingCompleted(elmParser: XmlElementParser) {
        super.onParsingCompleted(elmParser)
        
        if let  ptParser = elmParser as? XmlPointParser,
                pt = ptParser.point {
            _link.segment.add(pt)
        }
    }
    
    
    var _link : DiagramElements.Link
}
