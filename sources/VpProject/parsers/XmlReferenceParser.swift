//
// Created by Danny Thibaudeau on 15-08-29.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements

class XmlReferenceParser : XmlSubTreeParser {

    init( name: String, model: Model, delegate: XmlElementParserDelegate! = nil) {
        _model = model

        super.init(name: name, delegate: delegate)
    }

    override func onGlobalEndElement(elementName: String, namespaceURI: String?, qualifiedName: String?) {

        if let  id = _subDiagramId,
                name = _subDiagramName,
                origin = _diagramOrigin {

            let originElements = origin.componentsSeparatedByString(";")

            for elm in originElements {
                let ref = ModelReference(id: id, name: name, origin: elm)
                _model.subDiagrams.add(ref)
            }
        }
        else if let path = _filePath,
                    origin = _diagramOrigin {
                        
            let originElements = origin.componentsSeparatedByString(";")
            
            for elm in originElements {
                let ref = FileReference(path: path, origin: elm)
                _model.fileReferences.add(ref)
            }
        }

        super.onGlobalEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName)
    }

    override func onLocalStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject:AnyObject]) {

        switch elementName {

            case "StringProperty":
                onStringProperty(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)

            default:
                break
        }
    }

    func onStringProperty(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject:AnyObject]) {

        if let  name = attributeDict["name"] as? String,
                diagramName = attributeDict["diagramName"] as? String,
                value = attributeDict["value"] as? String where name == "url" {
            _subDiagramId = value
            _subDiagramName = diagramName
        }

        if let  name = attributeDict["name"] as? String,
                value = attributeDict["value"] as? String where name == "description" {

            _diagramOrigin = value
        }

        if let  _ = attributeDict["displayName"] as? String,
                pathName = attributeDict["pathName"] as? String,
                value = attributeDict["value"] as? String {

            _filePath = value
//            debugPrint("url found for \(pathName) = '\(value)'")
        }
    }

    var _model: Model

    var _subDiagramId : String!
    var _subDiagramName : String!
    var _diagramOrigin : String!
    var _filePath : String!
}
