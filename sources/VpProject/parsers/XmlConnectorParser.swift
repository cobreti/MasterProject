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
    
    init( name : String, diagram : Diagram, delegate : XmlElementParserDelegate! = nil) {
        
        _diagram = diagram
        
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
            case "Points":
                if let lnk = _lnk {
                    pushElementParser(XmlPointsParser(name: "Points", link: lnk, delegate: self))
                }
            case "Caption":
                let formatter = NSNumberFormatter()

                if let  xStr = attributeDict["x"] as? String,
                        yStr = attributeDict["y"] as? String,
                        x = formatter.numberFromString(xStr)?.floatValue,
                        y = formatter.numberFromString(yStr)?.floatValue,
                        lnk = _lnk {
                    lnk.captionPos = Point(x: CGFloat(x), y: CGFloat(y))
                }
            case "MultiplicityCaption":
                let formatter = NSNumberFormatter()

                if let  xStr = attributeDict["x"] as? String,
                yStr = attributeDict["y"] as? String,
                x = formatter.numberFromString(xStr)?.floatValue,
                y = formatter.numberFromString(yStr)?.floatValue,
                lnk = _lnk {
                    lnk.multiplicityCaptionPos = Point(x: CGFloat(x), y: CGFloat(y))
                }
            default:
                break
        }
    }
    
    override func onElementParsingStarting(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {

        super.onElementParsingStarting(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
        
        var numberFormatter = NSNumberFormatter()
        
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        if let id = attributeDict["id"] as? String,
                xStr = attributeDict["x"] as? String,
                x = numberFormatter.numberFromString(xStr)?.floatValue,
                yStr = attributeDict["y"] as? String,
                y = numberFormatter.numberFromString(yStr)?.floatValue,
                widthStr = attributeDict["width"] as? String,
                width = numberFormatter.numberFromString(widthStr)?.floatValue,
                heightStr = attributeDict["height"] as? String,
                height = numberFormatter.numberFromString(heightStr)?.floatValue,
                to = attributeDict["to"] as? String,
                from = attributeDict["from"] as? String,
                modelId = attributeDict["model"] as? String,
                shapeType = attributeDict["shapeType"] as? String {

                var lnkType = LinkType.unknown

                if let t = LinkType(rawValue: shapeType) {
                    lnkType = t
                }

                _lnk = DiagramElements.Link(ownerDiagram: _diagram, type: lnkType)
                
                _lnk.box = Rect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(width), height: CGFloat(height))
                _lnk.name = id
                _lnk.id = id
                _lnk.to = LinkEndPoint(id: to)
                _lnk.from = LinkEndPoint(id: from)
                _lnk.modelId = modelId
                
                _diagram.add(_lnk)
        }
    }
    
    var _diagram : Diagram
    var _lnk : DiagramElements.Link!
}
