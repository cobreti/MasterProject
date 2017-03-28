//
//  XmlLinkEndpointParser.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-20.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements

class XmlConnectorEndPointParser : XmlSubTreeParser {
    
    init( name : String, linkEndPoint : LinkEndPoint, delegate : XmlElementParserDelegate! = nil) {

        _linkEndPoint = linkEndPoint
        
        super.init(name: name, delegate: delegate)
    }
    
    override func onGlobalStartElement(_ elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [AnyHashable: Any]) {

        if elementName == "StringProperty" {
            
            if let  name = attributeDict["name"] as? String,
                    let value = attributeDict["value"] as? String, name == "aggregationKind" {
                
                if let endPointType = LinkEndPointType(rawValue: value) {
                    _linkEndPoint.type = endPointType
                }
            }

            if let  name = attributeDict["name"] as? String,
                    let value = attributeDict["value"] as? String, name == "multiplicity" && value != "Unspecified" {
                _linkEndPoint.multiplicity = value
            }
        }

        super.onGlobalStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
    }

    var _linkEndPoint : LinkEndPoint
    
}

