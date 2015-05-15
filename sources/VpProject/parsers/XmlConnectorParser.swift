//
//  XmlConnectorParser.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-10.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements
import Shapes

class XmlConnectorParser : XmlSubTreeParser {
    
    init( name : String, diagramLayer : DiagramLayer, delegate : XmlElementParserDelegate! = nil) {
        
        _diagramLayer = diagramLayer

        super.init(name: name, delegate: delegate)
        
    }

    override func onStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {
     
        switch elementName {
            case "Connector":
                onConnector(attributeDict)
                break
            case "Points":
                pushElementParser(XmlPointsParser(name: "Points", link: _lnk, delegate: self))
            default:
                break
        }
        
        super.onStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
    }
    
    override func onEndElement(elementName: String, namespaceURI: String?, qualifiedName: String?) {
        super.onEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName)
    }

    func onConnector(attributeDict: [NSObject:AnyObject]) {
        
        var numberFormatter = NSNumberFormatter()
        
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        if let  id = attributeDict["id"] as? String,
            xStr = attributeDict["x"] as? String,
            x = numberFormatter.numberFromString(xStr)?.doubleValue,
            yStr = attributeDict["y"] as? String,
            y = numberFormatter.numberFromString(yStr)?.doubleValue,
            widthStr = attributeDict["width"] as? String,
            width = numberFormatter.numberFromString(widthStr)?.doubleValue,
            heightStr = attributeDict["height"] as? String,
            height = numberFormatter.numberFromString(heightStr)?.doubleValue,
            to = attributeDict["to"] as? String,
            from = attributeDict["from"] as? String {
                
                _lnk = DiagramElements.Link(ownerDiagram: _diagramLayer)
                
                _lnk.box = Rect(x: x, y: y, width: width, height: height)
                _lnk.name = id
                _lnk.id = id
                _lnk.idTo = to
                _lnk.idFrom = from
                
                _diagramLayer.add(_lnk)
        }
    }
    
    var _diagramLayer : DiagramLayer
    var _lnk : DiagramElements.Link!
}
