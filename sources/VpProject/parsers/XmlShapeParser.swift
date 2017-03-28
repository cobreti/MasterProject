//
//  XmlShapeParser.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-10.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements
import Shapes

class XmlShapeParser : XmlSubTreeParser {

    init( name : String, diagram : Diagram, delegate : XmlElementParserDelegate! = nil) {
        
        _diagram = diagram

        super.init(name: name, delegate: delegate)
        
    }

    override func onGlobalStartElement(_ elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [AnyHashable: Any]) {

        super.onGlobalStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
    }


    override func onGlobalEndElement(_ elementName: String, namespaceURI: String?, qualifiedName: String?) {

        super.onGlobalEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName)
    }

    
    override func onLocalStartElement(_ elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [AnyHashable: Any]) {
    }
    
    override func onElementParsingStarting(_ elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [AnyHashable: Any]) {

        super.onElementParsingStarting(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)

        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        if let  id = attributeDict["id"] as? String,
                let name = attributeDict["name"] as? String,
                let xStr = attributeDict["x"] as? String,
                let x = numberFormatter.number(from: xStr)?.floatValue,
                let yStr = attributeDict["y"] as? String,
                let y = numberFormatter.number(from: yStr)?.floatValue,
                let widthStr = attributeDict["width"] as? String,
                let width = numberFormatter.number(from: widthStr)?.floatValue,
                let heightStr = attributeDict["height"] as? String,
                let height = numberFormatter.number(from: heightStr)?.floatValue,
                let modelId = attributeDict["model"] as? String {
        
            let elm = DiagramElements.Element(ownerDiagram: _diagram)
            
            elm.box = Rect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(width), height: CGFloat(height))
            elm.name = name
            elm.id = id
            elm.modelId = modelId
            
            _diagram.add(elm)
        }
    }

    var _diagram : Diagram
}
