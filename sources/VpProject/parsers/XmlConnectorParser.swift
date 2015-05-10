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

class XmlConnectorParser : XmlElementParser {
    
    override func onStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {
     
        switch elementName {
            case "Connector":
                onConnector(attributeDict)
                break
            default:
                break
        }
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
            from = attributeDict["from"] as? String,
            currentDiag = docParser.currentDiagram {
                
                var lnk = DiagramElements.Link(ownerDiagram: currentDiag)
                
                lnk.box = Rect(x: x, y: y, width: width, height: height)
                lnk.name = id
                lnk.id = id
                lnk.idTo = to
                lnk.idFrom = from
                
                currentDiag.add(lnk)
        }
    }
}
