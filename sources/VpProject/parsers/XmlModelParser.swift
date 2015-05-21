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
    
    
    init( name : String, modelsTable : ModelsTable, delegate : XmlElementParserDelegate! = nil) {
        
        _modelsTable = modelsTable
        
        super.init(name: name, delegate: delegate)
    }
    
    convenience init(name: String, parent: Model, delegate: XmlElementParserDelegate! = nil) {
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
            case "ChildModels":
                if let parentModel = _model {
                    pushElementParser( XmlModelsParser(name: "ChildModels", parent: parentModel, delegate: self) )
                }
            case "FromEnd":
                if let parentModel = _model {
                    _model.linkEndPointFrom = LinkEndPoint()
                    pushElementParser( XmlLinkEndpointParser(name: "FromEnd", linkEndPoint: _model.linkEndPointFrom, delegate: self) )
                }
            case "ToEnd":
                if let parentModel = _model {
                    _model.linkEndPointTo = LinkEndPoint()
                    pushElementParser( XmlLinkEndpointParser(name: "ToEnd", linkEndPoint: _model.linkEndPointTo, delegate: self) )
                }
            default:
                break
        }
    }
    
    override func onElementParsingStarting(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {
        
        super.onElementParsingStarting(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)

        if let  id = attributeDict["id"] as? String {
                
            if id == "u40n6rKFS_jUtA4d" {
                debugPrintln("wanted element")
            }
            
//            debugPrintln("==> found model element of name \(name)")
            
            _model = Model(id: id, parent: _parent)
            _modelsTable.add(_model)
        }
    }
    
    
    var _model : Model!
    var _modelsTable : ModelsTable
    var _parent : Model!
}