//
//  XmlDiagramParser.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-10.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements

class XmlDiagramParser : XmlElementParser {

    override func onStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject : AnyObject]) {

        switch elementName {
            case "Diagram":
                onDiagram(attributeDict)
                break
            default:
                break
        }
    }

    override func onEndElement(elementName: String, namespaceURI: String?, qualifiedName: String?) {

        super.onEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName)

        switch elementName {
            case "Diagram":
                docParser.currentDiagram = nil
                break
            default:
                break
        }
    }


    func onDiagram(attributeDict: [NSObject:AnyObject]) {
        
        if let name = attributeDict["name"] as? String {
            debugPrintln("Diagram node of name : \(name)")
            var diag = DiagramLayer(name: name)
            document.layers.add(diag)
            docParser.currentDiagram = diag
        }
    }
}
