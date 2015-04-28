//
// Created by Danny Thibaudeau on 15-04-27.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class XMLParsingTest : NSObject, NSXMLParserDelegate {

    override init() {

        super.init()

        var url = NSBundle.mainBundle().URLForResource("ProjectFV",
                                                       withExtension: "xml",
                                                       subdirectory: "EmbeddedRes/diagrams")

        var parser = NSXMLParser(contentsOfURL: url)

        debugPrintln("after parser created")
        
        parser?.delegate = self
        parser?.parse()
    }

    func parser(parser: NSXMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [NSObject:AnyObject]) {

        if let modelType = attributeDict["displayModelType"] as? String,
                name = attributeDict["name"] as? String where modelType == "Class" {
            debugPrintln(" - \(elementName) --> \(name)")
        }

    }
}

