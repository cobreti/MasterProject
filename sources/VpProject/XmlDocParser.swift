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
            var diag = DiagramLayer(name: name)
            _doc.layers.add(diag)
            currentDiagram = diag
        }
    }

    /**
     *
     */
    func onShape(attributeDict: [NSObject:AnyObject]) {

        if let  id = attributeDict["id"] as? String,
                name = attributeDict["name"] as? String,
                x = attributeDict["x"] as? String,
                y = attributeDict["y"] as? String,
                width = attributeDict["width"] as? String,
                height = attributeDict["height"] as? String,
                currentDiag = _currentDiagram {

            var elm = DiagramElements.Element()
            var numberFormatter = NSNumberFormatter()

            numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle

            elm.x = numberFormatter.numberFromString(x)?.floatValue
            elm.y = numberFormatter.numberFromString(y)?.floatValue
            elm.width = numberFormatter.numberFromString(width)?.floatValue
            elm.height = numberFormatter.numberFromString(height)?.floatValue
            elm.name = name
            elm.id = id
                    
            currentDiag.add(elm)
        }
    }

    var _currentDiagram : DiagramLayer!

    var _doc : DiagramElements.Document
}

