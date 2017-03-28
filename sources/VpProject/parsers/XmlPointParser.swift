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
    
    override func onElementParsingStarting(_ elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [AnyHashable: Any]) {

        super.onElementParsingStarting(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)

        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        if let  xStr = attributeDict["x"] as? String,
                let x = numberFormatter.number(from: xStr)?.floatValue,
                let yStr = attributeDict["y"] as? String,
                let y = numberFormatter.number(from: yStr)?.floatValue {
        
            _pt = Point(x: CGFloat(x), y: CGFloat(y))
        }
    }


    var _pt : Point!
}

