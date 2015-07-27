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
            case "StringProperty":
                onStringProperty(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
            case "HTMLProperty":
                onHTMLProperty(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
            case "ChildModels":
                if let parentModel = _model {
                    pushElementParser( XmlModelsParser(name: "ChildModels", parent: parentModel, delegate: self) )
                }
            case "FromEnd":
                if let parentModel = _model {
                    _model.linkEndPointFrom = LinkEndPoint()
                    pushElementParser( XmlConnectorEndPointParser(name: "FromEnd", linkEndPoint: _model.linkEndPointFrom, delegate: self) )
                }
            case "ToEnd":
                if let parentModel = _model {
                    _model.linkEndPointTo = LinkEndPoint()
                    pushElementParser( XmlConnectorEndPointParser(name: "ToEnd", linkEndPoint: _model.linkEndPointTo, delegate: self) )
                }
            default:
                break
        }
    }
    
    override func onElementParsingStarting(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {
        
        super.onElementParsingStarting(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)

        if let  id = attributeDict["id"] as? String {
            _model = Model(id: id, parent: _parent)
            _modelsTable.add(_model)
        }
    }
    
    
    func onStringProperty(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {
        
        
        if let  displayName = attributeDict["displayName"] as? String,
                pathName = attributeDict["pathName"] as? String,
                value = attributeDict["value"] as? String {
                
            _model?.filePath = value
            debugPrint("url found for \(pathName) = '\(value)'")
        }
        
        if let  diagramName = attributeDict["diagramName"] as? String,
                diagramType = attributeDict["diagramType"] as? String,
                displayName = attributeDict["displayName"] as? String,
                name = attributeDict["name"] as? String,
                value = attributeDict["value"] as? String {
                
            _model?.subDiagramName = diagramName
            debugPrint("sub diagram with name : \(diagramName)")
        }
    }

    func onHTMLProperty(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject:AnyObject]) {

        if let  name = attributeDict["name"] as? String,
                displayName = attributeDict["displayName"] as? String,
                plainTextValue = attributeDict["plainTextValue"] as? String where name == "documentation" && displayName == "Description" {

            _model?.plainTextValue = plainTextValue
        }
    }
    
    var _model : Model!
    var _modelsTable : ModelsTable
    var _parent : Model!
}