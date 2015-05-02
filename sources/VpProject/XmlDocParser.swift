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
    }

    func parser(parser: NSXMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [NSObject:AnyObject]) {

        switch elementName {
            case "Diagram":
                self.onDiagram(attributeDict)
            default:
                debugPrintln("unhandled element")
        }

        debugPrintln("--> element name : \(elementName)")

        if let modelType = attributeDict["displayModelType"] as? String,
        name = attributeDict["name"] as? String where modelType == "Class" {
            debugPrintln(" - \(elementName) --> \(name)")
        }
    }

    func onDiagram(attributeDict: [NSObject:AnyObject]) {

        if let name = attributeDict["name"] as? String {
            _doc.layers.add(DiagramLayer(name: name))
        }
    }

    var _doc : DiagramElements.Document
}
