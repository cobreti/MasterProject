//
//  XmlPointParser.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-15.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import Shapes

class XmlPointParser : XmlElementParser {

    var point : Point! {
        get {
            return _pt
        }
    }
    
    override func onStartElement(    elementName : String,
                                    namespaceURI : String?,
                                    qualifiedName : String?,
                                    attributeDict : [NSObject:AnyObject]) {
     
        switch elementName {
            case "Point":
                onPoint(attributeDict)
            default:
                break
        }
    }


    func onPoint(attributes : [NSObject:AnyObject]) {

        var numberFormatter = NSNumberFormatter()

        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle

        if let  xStr = attributes["x"] as? String,
                x = numberFormatter.numberFromString(xStr)?.doubleValue,
                yStr = attributes["y"] as? String,
                y = numberFormatter.numberFromString(yStr)?.doubleValue {

            _pt = Point(x: x, y: y)
        }
    }

    var _pt : Point!
}

