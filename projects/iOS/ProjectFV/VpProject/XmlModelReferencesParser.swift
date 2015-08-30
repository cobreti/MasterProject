//
// Created by Danny Thibaudeau on 15-08-29.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import DiagramElements

class XmlModelReferencesParser : XmlSubTreeParser {

    init( name: String, model: Model, delegate: XmlElementParserDelegate! = nil) {
        _model = model

        super.init(name: name, delegate: delegate)
    }

    override func onGlobalStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject:AnyObject]) {
        super.onGlobalStartElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)
    }

    override func onGlobalEndElement(elementName: String, namespaceURI: String?, qualifiedName: String?) {
        super.onGlobalEndElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName)
    }

    override func onLocalStartElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject:AnyObject]) {

        switch elementName {

            case "Model":
                onModelElement(elementName, namespaceURI: namespaceURI, qualifiedName: qualifiedName, attributeDict: attributeDict)

            default:
                break
        }

    }

    func onModelElement(elementName: String, namespaceURI: String?, qualifiedName: String?, attributeDict: [NSObject:AnyObject]) {

        if let modelType = attributeDict["modelType"] as? String where modelType == "Reference" {
            pushElementParser( XmlModelReferenceParser(name: "Model", model: _model, delegate: self) )
        }
    }


    var _model : Model
}
