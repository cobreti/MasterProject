//
//  SchematicViewTBController.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-09-13.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class SchematicViewTBController : UIViewController {

    typealias RecenterDelegate = () -> Void

    var recenterDelegate : RecenterDelegate! {
        get {
            return _recenterDelegate
        }
        set(delegate) {
            _recenterDelegate = delegate
        }
    }

    var diagramName : String! {
        get {
            return _diagramNameLabel?.text
        }
        set (value) {
            if let text = value {
                _diagramNameLabel?.text = text
            }
            else {
                _diagramNameLabel?.text = ""
            }
        }
    }

    @IBAction func onRecenter(sender: AnyObject) {
        _recenterDelegate?()
    }
    
    @IBOutlet weak var _diagramNameLabel: UILabel!

    var _recenterDelegate : RecenterDelegate!
}