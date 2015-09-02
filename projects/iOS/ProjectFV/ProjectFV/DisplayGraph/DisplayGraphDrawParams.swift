//
// Created by Danny Thibaudeau on 15-08-16.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class DisplayGraphDrawParams {

    var context: CGContext {
        get {
            return _context
        }
    }

    var portal: DiagramPortal {
        get {
            return _portal
        }
    }

    var drawingMode: ViewDrawingMode {
        get {
            return _drawingMode
        }
    }

    init(ctx: CGContext, portal: DiagramPortal, drawingMode: ViewDrawingMode = .Normal) {
        _context = ctx
        _portal = portal
        _drawingMode = drawingMode
    }

    var _context: CGContext
    var _portal: DiagramPortal
    var _drawingMode : ViewDrawingMode
}