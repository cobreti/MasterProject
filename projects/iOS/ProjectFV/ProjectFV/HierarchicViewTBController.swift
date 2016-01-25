//
//  HierarchicViewTBController.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2016-01-24.
//  Copyright © 2016 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class HierarchicViewTBController : UIViewController {
    
    typealias ShowQuestionRechercheDelegate = () -> Void
    
    var showQuestionRechercheDelegate: ShowQuestionRechercheDelegate! {
        get {
            return _showQuestionRechercheDelegate
        }
        set(delegate) {
            _showQuestionRechercheDelegate = delegate
        }
    }
    
    @IBAction func onShowQuestion(sender: AnyObject) {
        _showQuestionRechercheDelegate?()
    }
    
    var _showQuestionRechercheDelegate : ShowQuestionRechercheDelegate!
}
