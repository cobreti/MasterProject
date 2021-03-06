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
    
    override func onGlobalStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {
        
        super.onGlobalStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
    }
    
    override func onGlobalEndElement(elementName: String, namespaceURI: String?, qualifiedName: String?) {
        
        super.onGlobalEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName)
    }
    
    override func onLocalStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {
        switch elementName {
            case "Shape":
                pushElementParser(XmlShapeParser(name: "Shape", diagram: _diagram, delegate: self))
            case "Connector":
                pushElementParser(XmlConnectorParser(name: "Connector", diagram: _diagram, delegate: self))
            default:
                break
        }
    }
    
    override func onElementParsingStarting(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {
        
        super.onElementParsingStarting(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)

        if let name = attributeDict["name"] as? String {
//            debugPrintln("Diagram node of name : \(name)")
            _diagram = Diagram(name: name)
            _document.diagrams.add(_diagram)
        }
    }
    
    override func onElementParsingCompleted() {
        _diagram?.updateBoundingBox()
    }
    
    
    var _diagram : Diagram!
    var _document : DiagramElements.Document
}
