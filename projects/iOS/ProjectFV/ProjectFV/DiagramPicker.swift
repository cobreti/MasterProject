//
//  DiagramPicker.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-07.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import DiagramElements
import Shapes

class DiagramPicker {
    
    init(   document: Document,
            layer: DiagramLayer,
            portal: DiagramPortal ) {
        _portal = portal
        _document = document
        _layer = layer
    }
    
    var _portal : DiagramPortal
    var _document : Document
    var _layer : DiagramLayer
}
