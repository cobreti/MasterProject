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
    typealias ShowQuestionRechercheDelegate = () -> Void

    var recenterDelegate : RecenterDelegate! {
        get {
            return _recenterDelegate
        }
        set(delegate) {
            _recenterDelegate = delegate
        }
    }

    var showQuestionRechercheDelegate: ShowQuestionRechercheDelegate! {
        get {
            return _showQuestionRechercheDelegate
        }
        set(delegate) {
            _showQuestionRechercheDelegate = delegate
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
    
    @IBAction func onShowQuestion(sender: AnyObject) {
        _showQuestionRechercheDelegate?()
    }
    
    @IBOutlet weak var _diagramNameLabel: UILabel!

    var _recenterDelegate : RecenterDelegate!
    var _showQuestionRechercheDelegate : ShowQuestionRechercheDelegate!
}