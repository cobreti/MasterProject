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
    
    init( name : String, modelsTable : ModelsTable, delegate : XmlElementParserDelegate! = nil) {
        
        _modelsTable =  modelsTable
        
        super.init(name: name, delegate: delegate)
    }

    convenience init(name : String, parent : Model, delegate : XmlElementParserDelegate! = nil) {
        self.init(name: name, modelsTable: parent.children, delegate: delegate)
        
        _parent = parent
    }

    override func onGlobalStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {
        
        super.onGlobalStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
    }

    override func onGlobalEndElement(elementName: String, namespaceURI: String?, qualifiedName: String?) {
                
        super.onGlobalEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName)
    }
    
    override func onLocalStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {
        
        switch elementName {
            case "Model":
                if let parent = _parent {
                    pushElementParser(XmlModelParser(name: "Model", parent: parent, delegate: self))
                }
                else {
                    pushElementParser(XmlModelParser(name: "Model", modelsTable: _modelsTable, delegate: self))
                }
            default:
                break
        }
    }
    
    var _modelsTable : ModelsTable
    var _parent : Model!
}
