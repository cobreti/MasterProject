//
//  XmlParserState.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-20.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class XmlParserState {
    
    var name : String {
        get {
            return _name
        }
    }
    
    var namespaceURI : String? {
        get {
            return _namespaceURI
        }
    }
    
    var qualifiedName : String? {
        get {
            return _qualifiedName
        }
    }
    
    var attributeDict : [NSObject:AnyObject] {
        get {
            return _attributeDict
        }
    }
    
    init(   elementName : String,
            namespaceURI : String?,
            qualifiedName : String?,
            attributeDict : [NSObject:AnyObject]) {
            
        _name = elementName
        _namespaceURI = namespaceURI
        _qualifiedName = qualifiedName
        _attributeDict = attributeDict
    }
    
    var _name : String
    var _namespaceURI : String?
    var _qualifiedName : String?
    var _attributeDict : [NSObject:AnyObject]
}