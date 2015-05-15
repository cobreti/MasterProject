//
//  XmlDiagramParser.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-10.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements

class XmlDiagramParser : XmlSubTreeParser {

    init( name : String, document : DiagramElements.Document, delegate : XmlElementParserDelegate! = nil) {
        
        _document = document

        super.init(name: name, delegate: delegate)
        
    }

    override func onStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {

        switch elementName {
            case "Diagram":
                onDiagram(attributeDict)
            case "Shape":
                pushElementParser(XmlShapeParser(name: "Shape", diagramLayer: _diagram, delegate: self))
            case "Connector":
                pushElementParser(XmlConnectorParser(name: "Connector", diagramLayer: _diagram, delegate: self))
            default:
                break
        }
        
        super.onStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
    }

    override func onEndElement(elementName: String, namespaceURI: String?, qualifiedName: String?) {

        if _name == elementName {
            _diagram?.updateBoundingBox()
        }
        
        super.onEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName)
    }


    func onDiagram(attributeDict: [NSObject:AnyObject]) {
        
        if let name = attributeDict["name"] as? String {
            debugPrintln("Diagram node of name : \(name)")
            _diagram = DiagramLayer(name: name)
            _document.layers.add(_diagram)
        }
    }

    var _diagram : DiagramLayer!
    var _document : DiagramElements.Document
}
