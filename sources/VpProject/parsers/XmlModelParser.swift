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
    
    override func onGlobalStartElement(_ elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [AnyHashable: Any]) {
        
        
        super.onGlobalStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
    }
    
    override func onGlobalEndElement(_ elementName: String, namespaceURI: String?, qualifiedName: String?) {
        
        super.onGlobalEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName)
    }
    
    override func onLocalStartElement(_ elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [AnyHashable: Any]) {
        
        switch elementName {
            case "ModelsProperty":
                onModelsProperty(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
            case "StringProperty":
                onStringProperty(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
            case "HTMLProperty":
                onHTMLProperty(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
            case "ChildModels":
                if let parentModel = _model {
                    pushElementParser( XmlModelsParser(name: "ChildModels", parent: parentModel, delegate: self) )
                }
            case "FromEnd":
                if let _ = _model {
                    _model.linkEndPointFrom = LinkEndPoint()
                    pushElementParser( XmlConnectorEndPointParser(name: "FromEnd", linkEndPoint: _model.linkEndPointFrom, delegate: self) )
                }
            case "ToEnd":
                if let _ = _model {
                    _model.linkEndPointTo = LinkEndPoint()
                    pushElementParser( XmlConnectorEndPointParser(name: "ToEnd", linkEndPoint: _model.linkEndPointTo, delegate: self) )
                }
            default:
                break
        }
    }
    
    override func onElementParsingStarting(_ elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [AnyHashable: Any]) {
        
        super.onElementParsingStarting(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)

        if let  id = attributeDict["id"] as? String {
            _model = Model(id: id, parent: _parent)
            _modelsTable.add(_model)
        }
    }

    func onModelsProperty(_ elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [AnyHashable: Any]) {

        if let  name = attributeDict["name"] as? String, name == "references" {
            pushElementParser( XmlReferencesParser(name: "ModelsProperty", model: _model, delegate: self) )
        }
    }
    
    func onStringProperty(_ elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [AnyHashable: Any]) {
        
        
//        if let  displayName = attributeDict["displayName"] as? String,
//                pathName = attributeDict["pathName"] as? String,
//                value = attributeDict["value"] as? String {
//
//            _model?.filePath = value
//            debugPrint("url found for \(pathName) = '\(value)'")
//        }
        
//        if let  diagramName = attributeDict["diagramName"] as? String,
//                diagramType = attributeDict["diagramType"] as? String,
//                displayName = attributeDict["displayName"] as? String,
//                name = attributeDict["name"] as? String,
//                value = attributeDict["value"] as? String {
//
//            _model?.subDiagramName = diagramName
//            debugPrint("sub diagram with name : \(diagramName)")
//        }

        if let  _ = attributeDict["name"] as? String,
                let value = attributeDict["value"] as? String {
            _model?.name = value
        }
    }

    func onHTMLProperty(_ elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [AnyHashable: Any]) {

        if let  name = attributeDict["name"] as? String,
                let displayName = attributeDict["displayName"] as? String,
                let plainTextValue = attributeDict["plainTextValue"] as? String, name == "documentation" && displayName == "Description" {

            _model?.plainTextValue = plainTextValue
        }
    }
    
    var _model : Model!
    var _modelsTable : ModelsTable
    var _parent : Model!
}
