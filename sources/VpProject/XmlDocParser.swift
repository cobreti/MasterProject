//
// Created by Danny Thibaudeau on 15-05-01.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements

class XmlDocParser : NSObject, NSXMLParserDelegate {

    init( doc : DiagramElements.Document ) {

        _doc = doc
    }

    func parse( url : NSURL ) {

        var parser = NSXMLParser(contentsOfURL: url)

        parser?.delegate = self
        parser?.parse()
        
        currentDiagram = nil
    }
    
    var currentDiagram : DiagramLayer! {
        get {
            return _currentDiagram
        }
        set(diag) {
            
            if let d = _currentDiagram {
                
                d.updateBoundingBox()
                debugPrintln(d)
            }
            
            _currentDiagram = diag
        }
    }

    /**
     *
     */
    func parser(parser: NSXMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [NSObject:AnyObject]) {

        switch elementName {
            case "Diagram":
                self.onDiagram(attributeDict)
            case "Shape":
                self.onShape(attributeDict)
            case "Connector":
                self.onConnector(attributeDict)
            default:
                debugPrintln("unhandled element")
        }

        debugPrintln("--> element name : \(elementName)")

        if let modelType = attributeDict["displayModelType"] as? String,
        name = attributeDict["name"] as? String where modelType == "Class" {
            debugPrintln(" - \(elementName) --> \(name)")
        }
    }

    /**
     *   handle Diagram node
     */
    func onDiagram(attributeDict: [NSObject:AnyObject]) {

        if let name = attributeDict["name"] as? String {
            debugPrintln("Diagram node of name : \(name)")
            var diag = DiagramLayer(name: name)
            _doc.layers.add(diag)
            currentDiagram = diag
        }
    }

    /**
     *
     */
    func onShape(attributeDict: [NSObject:AnyObject]) {

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
                currentDiag = _currentDiagram {

            var elm = DiagramElements.Element()

            elm.x = CGFloat(x)
            elm.y = CGFloat(y)
            elm.width = CGFloat(width)
            elm.height = CGFloat(height)
            elm.name = name
            elm.id = id
                    
            currentDiag.add(elm)
        }
    }

    /**
    *
    */
    func onConnector(attributeDict: [NSObject:AnyObject]) {
        
        var numberFormatter = NSNumberFormatter()
        
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle

        if let  id = attributeDict["id"] as? String,
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
                currentDiag = _currentDiagram {
                
                var lnk = DiagramElements.Link()
                
                lnk.x = CGFloat(x)
                lnk.y = CGFloat(y)
                lnk.width = CGFloat(width)
                lnk.height = CGFloat(height)
                lnk.name = id
                lnk.id = id
                lnk.idTo = to
                lnk.idFrom = from
                
                currentDiag.add(lnk)
        }
    }

    var _currentDiagram : DiagramLayer!

    var _doc : DiagramElements.Document
}

