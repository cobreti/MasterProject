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

    init( name : String, diagramLayer : DiagramLayer, delegate : XmlElementParserDelegate! = nil) {
        
        _diagramLayer = diagramLayer

        super.init(name: name, delegate: delegate)
        
    }

    override func onGlobalStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {

        super.onGlobalStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
    }


    override func onGlobalEndElement(elementName: String, namespaceURI: String?, qualifiedName: String?) {

        super.onGlobalEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName)
    }

    
    override func onLocalStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {
    }
    
    override func onElementParsingStarting(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {

        super.onElementParsingStarting(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)

        var numberFormatter = NSNumberFormatter()
        
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        if let  id = attributeDict["id"] as? String,
                name = attributeDict["name"] as? String,
                xStr = attributeDict["x"] as? String,
                x = numberFormatter.numberFromString(xStr)?.floatValue,
                yStr = attributeDict["y"] as? String,
                y = numberFormatter.numberFromString(yStr)?.floatValue,
                widthStr = attributeDict["width"] as? String,
                width = numberFormatter.numberFromString(widthStr)?.floatValue,
                heightStr = attributeDict["height"] as? String,
                height = numberFormatter.numberFromString(heightStr)?.floatValue,
                modelId = attributeDict["model"] as? String {
        
            var elm = DiagramElements.Element(ownerDiagram: _diagramLayer)
            
            elm.box = Rect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(width), height: CGFloat(height))
            elm.name = name
            elm.id = id
            elm.modelId = modelId
            
            _diagramLayer.add(elm)
        }
    }

    var _diagramLayer : DiagramLayer
}