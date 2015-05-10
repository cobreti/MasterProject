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

class XmlShapeParser : XmlElementParser {

    override func onStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {

        switch elementName {
            case "Shape":
                onShape(attributeDict)
                break
            default:
                break
        }
    }


    override func onEndElement(elementName: String, namespaceURI: String?, qualifiedName: String?) {

        super.onEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName)
    }


    func onShape(attributeDict: [NSObject:AnyObject]) {

        var numberFormatter = NSNumberFormatter()

        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle

        if let  id = attributeDict["id"] as? String,
        name = attributeDict["name"] as? String,
        xStr = attributeDict["x"] as? String,
        x = numberFormatter.numberFromString(xStr)?.doubleValue,
        yStr = attributeDict["y"] as? String,
        y = numberFormatter.numberFromString(yStr)?.doubleValue,
        widthStr = attributeDict["width"] as? String,
        width = numberFormatter.numberFromString(widthStr)?.doubleValue,
        heightStr = attributeDict["height"] as? String,
        height = numberFormatter.numberFromString(heightStr)?.doubleValue,
        currentDiag = docParser.currentDiagram {

            var elm = DiagramElements.Element(ownerDiagram: currentDiag)

            elm.box = Rect(x: x, y: y, width: width, height: height)
            elm.name = name
            elm.id = id

            currentDiag.add(elm)
        }
    }
}