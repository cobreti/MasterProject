//
// Created by Danny Thibaudeau on 15-08-02.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class MethodSelectionViewController : UIViewController {

    @IBAction func onSchematiqueSelected(sender: AnyObject) {
        
        Application.instance().actionsBus.send( MethodSelectionAction(method: .Schematique, sender: self) )
    }
    
    @IBAction func onHierarchiqueSelected(sender: AnyObject) {
    
        Application.instance().actionsBus.send( MethodSelectionAction(method: .Hierarchique, sender: self) )
    }
}
