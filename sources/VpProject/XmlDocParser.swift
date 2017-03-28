//
// Created by Danny Thibaudeau on 15-05-01.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements
import Shapes

class XmlDocParser : NSObject, XMLParserDelegate {

    init( doc : DiagramElements.Document ) {

        _doc = doc
    }

    func parse( _ url : URL ) {

        let parser = XMLParser(contentsOf: url)

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
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String: String]) {

        _xmlState = XmlParserState(elementName: elementName, namespaceURI: namespaceURI, qualifiedName: qName, attributeDict: attributeDict)
                    
        switch elementName {
            case "Diagram":
                pushElementParser(XmlDiagramParser(name: "Diagram", document: self.document))
            case "Models":
                pushElementParser(XmlModelsParser(name: "Models", modelsTable: self.document.models))
            default:
            onUnhandledElement()
//                debugPrintln("unhandled element")
        }

//        debugPrintln("--> element name : \(elementName)")

//        if let modelType = attributeDict["displayModelType"] as? String,
//                name = attributeDict["name"] as? String where modelType == "Class" {
//            debugPrintln(" - \(elementName) --> \(name)")
//        }
                    
        if let p = currentParser {
            p.onGlobalStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qName, attributeDict: attributeDict)
        }
    }
    
    func onUnhandledElement() {
        
    }

    func parser(    _ parser: XMLParser,
                    didEndElement elementName: String,
                    namespaceURI: String?,
                    qualifiedName qName: String?) {

        if let p = currentParser {
            p.onGlobalEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qName)
        }
    }

    func pushElementParser( _ parser : XmlElementParser ) {
        _elementParsers.append(parser)
        
        if let state = _xmlState {
            parser.onElementParsingStarting(state.name, namespaceURI: state.namespaceURI, qualifiedName: state.qualifiedName, attributeDict: state.attributeDict)
        }
    }

    func popElementParser( _ parser : XmlElementParser ) {
        _elementParsers.removeLast()
    }

    /**
    *
    */
    func onPoints(_ attributeDict : [AnyHashable: Any]) {
        
    }

    var _elementParsers : [XmlElementParser] = []
    var _doc : DiagramElements.Document
    var _xmlState : XmlParserState!
}

