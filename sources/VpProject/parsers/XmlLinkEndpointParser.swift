//
//  XmlLinkEndpointParser.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-20.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements

class XmlLinkEndpointParser : XmlSubTreeParser {
    
    init( name : String, linkEndPoint : LinkEndPoint, delegate : XmlElementParserDelegate! = nil) {

        _linkEndPoint = linkEndPoint
        
        super.init(name: name, delegate: delegate)
    }
    
    override func onGlobalStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {

        if elementName == "StringProperty" {
            
            if let  name = attributeDict["name"] as? String,
                    value = attributeDict["value"] as? String where name == "aggregationKind" {
                
                if let endPointType = LinkEndPointType(rawValue: value) {
                    _linkEndPoint.type = endPointType
                }
            }
        }

        super.onGlobalStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
    }

    var _linkEndPoint : LinkEndPoint
    
}

