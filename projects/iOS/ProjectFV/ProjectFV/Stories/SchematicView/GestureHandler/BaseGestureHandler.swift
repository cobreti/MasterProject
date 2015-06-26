//
//  BaseGestureHandler.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-24.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class BaseGestureHandler : NSObject {
    
    var view : DiagramView {
        get {
            return _view
        }
    }
    
    var portal : DiagramPortal {
        get {
            return _portal
        }
    }
    
    var delegate : GestureHandlerDelegate! {
        get {
            return _delegate
        }
    }
    
    var enabled : Bool {
        get {
            return _enabled
        }
        set (value) {
            _enabled = value
        }
    }
    
    init( view: DiagramView, portal: DiagramPortal, delegate: GestureHandlerDelegate! ) {
        _view = view
        _portal = portal
        _delegate = delegate
    }
    
    private var _view : DiagramView
    private var _portal : DiagramPortal
    private var _delegate : GestureHandlerDelegate!
    private var _enabled : Bool = true
}