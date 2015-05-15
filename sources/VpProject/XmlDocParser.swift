//
// Created by Danny Thibaudeau on 15-05-01.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements
import Shapes

class XmlDocParser : NSObject, NSXMLParserDelegate {

    init( doc : DiagramElements.Document ) {

        _doc = doc
    }

    func parse( url : NSURL ) {

        var parser = NSXMLParser(contentsOfURL: url)

        parser?.delegate = self
        parser?.parse()
    }
    
    var currentParser : XmlElementParser! {
        get {
            return _elementParsers.last
        }
    }
    
    var document : DiagramElements.Document! {
        get {
            return _doc
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
                pushElementParser(XmlDiagramParser(name: "Diagram", document: self.document))
            default:
                debugPrintln("unhandled element")
        }

        debugPrintln("--> element name : \(elementName)")

        if let modelType = attributeDict["displayModelType"] as? String,
        name = attributeDict["name"] as? String where modelType == "Class" {
            debugPrintln(" - \(elementName) --> \(name)")
        }
                    
        if let p = currentParser {
            p.onStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qName, attributeDict: attributeDict)
        }
    }

    func parser(    parser: NSXMLParser,
                    didEndElement elementName: String,
                    namespaceURI: String?,
                    qualifiedName qName: String?) {

        if let p = currentParser {
            p.onEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qName)
        }
    }

    func pushElementParser( parser : XmlElementParser ) {
        _elementParsers.append(parser)
    }

    func popElementParser( parser : XmlElementParser ) {
        _elementParsers.removeLast()
    }

    /**
    *
    */
    func onPoints(attributeDict : [NSObject:AnyObject]) {
        
    }

    var _elementParsers : [XmlElementParser] = []
    var _doc : DiagramElements.Document
}

