//
//  XmlElementParserDelegate.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-15.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

protocol XmlElementParserDelegate {
    
    func onParsingCompleted( elmParser : XmlElementParser )
}
