//
//  XmlModelsParser.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-20.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements

class XmlModelsParser : XmlSubTreeParser {
    
    init( name : String, parent : ModelsTable, delegate : XmlElementParserDelegate! = nil) {
        
        _parent = parent
        
        super.init(name: name, delegate: delegate)
    }

    override func onGlobalStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {
        
        super.onGlobalStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
    }

    override func onGlobalEndElement(elementName: String, namespaceURI: String?, qualifiedName: String?) {
        
        if _name == elementName {
        }
        
        super.onGlobalEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName)
    }
    
    override func onLocalStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {
        
        switch elementName {
            case "Model":
                pushElementParser(XmlModelParser(name: "Model", parent: _parent, delegate: self))
            default:
                break
        }
    }
    
    var _parent : ModelsTable
}
