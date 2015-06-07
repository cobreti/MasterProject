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
    
    override func onElementParsingStarting(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {

        super.onElementParsingStarting(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)

        var numberFormatter = NSNumberFormatter()
        
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        if let  xStr = attributeDict["x"] as? String,
                x = numberFormatter.numberFromString(xStr)?.floatValue,
                yStr = attributeDict["y"] as? String,
                y = numberFormatter.numberFromString(yStr)?.floatValue {
        
            _pt = Point(x: CGFloat(x), y: CGFloat(y))
        }
    }


    var _pt : Point!
}

