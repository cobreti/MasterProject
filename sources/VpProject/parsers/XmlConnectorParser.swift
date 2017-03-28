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
    
    override func onGlobalStartElement(_ elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [AnyHashable: Any]) {
        
        super.onGlobalStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
    }
    
    override func onGlobalEndElement(_ elementName: String, namespaceURI: String?, qualifiedName: String?) {
        super.onGlobalEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName)
    }
    
    override func onLocalStartElement(_ elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [AnyHashable: Any]) {
        
        switch elementName {
            case "Points":
                if let lnk = _lnk {
                    pushElementParser(XmlPointsParser(name: "Points", link: lnk, delegate: self))
                }
            case "Caption":
                let formatter = NumberFormatter()

                if let  xStr = attributeDict["x"] as? String,
                        let yStr = attributeDict["y"] as? String,
                        let x = formatter.number(from: xStr)?.floatValue,
                        let y = formatter.number(from: yStr)?.floatValue,
                        let lnk = _lnk {
                    lnk.captionPos = Point(x: CGFloat(x), y: CGFloat(y))
                }
            case "MultiplicityCaption":
                let formatter = NumberFormatter()

                if let  xStr = attributeDict["x"] as? String,
                        let yStr = attributeDict["y"] as? String,
                        let x = formatter.number(from: xStr)?.floatValue,
                        let y = formatter.number(from: yStr)?.floatValue,
                        let lnk = _lnk {
                    lnk.multiplicityCaptionPos = Point(x: CGFloat(x), y: CGFloat(y))
                }
            default:
                break
        }
    }
    
    override func onElementParsingStarting(_ elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [AnyHashable: Any]) {

        super.onElementParsingStarting(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
        
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        if let  id = attributeDict["id"] as? String,
                let xStr = attributeDict["x"] as? String,
                let x = numberFormatter.number(from: xStr)?.floatValue,
                let yStr = attributeDict["y"] as? String,
                let y = numberFormatter.number(from: yStr)?.floatValue,
                let widthStr = attributeDict["width"] as? String,
                let width = numberFormatter.number(from: widthStr)?.floatValue,
                let heightStr = attributeDict["height"] as? String,
                let height = numberFormatter.number(from: heightStr)?.floatValue,
                let to = attributeDict["to"] as? String,
                let from = attributeDict["from"] as? String,
                let modelId = attributeDict["model"] as? String,
                let shapeType = attributeDict["shapeType"] as? String {

                var lnkType = LinkType.unknown

                if let t = LinkType(rawValue: shapeType) {
                    lnkType = t
                }

                _lnk = DiagramElements.Link(ownerDiagram: _diagram, type: lnkType)

                if let name = attributeDict["name"] as? String {
                    _lnk.name = name
                }

                _lnk.box = Rect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(width), height: CGFloat(height))
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
