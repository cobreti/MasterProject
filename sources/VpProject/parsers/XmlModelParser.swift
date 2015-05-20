//
//  XmlModelParser.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-20.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements

class XmlModelParser : XmlSubTreeParser {
    
    
    init( name : String, parent : ModelsTable, delegate : XmlElementParserDelegate! = nil) {
        
        _parent = parent
        
        super.init(name: name, delegate: delegate)
    }
    
    override func onGlobalStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {
        
        
        super.onGlobalStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
    }
    
    override func onGlobalEndElement(elementName: String, namespaceURI: String?, qualifiedName: String?) {
        
        super.onGlobalEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName)
    }
    
    override func onLocalStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {
        
        switch elementName {
            case "ChildModels":
                if let parentModel = _model {
                    pushElementParser( XmlModelsParser(name: "ChildModels", parent: parentModel.children, delegate: self) )
                }
            default:
                break
        }
    }
    
    override func onElementParsingStarting(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {
        
        super.onElementParsingStarting(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)

        if let  id = attributeDict["id"] as? String,
                name = attributeDict["name"] as? String {
                
//            if id == "HRo6vzKGAqAEZwfy" {
//                debugPrintln("wanted element")
//            }
            
//            debugPrintln("==> found model element of name \(name)")
            
            _model = Model(id: id)
            _parent.add(_model)
        }
    }
    
    
    var _model : Model!
    var _parent : ModelsTable
}