//
//  MainViewController.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-08-12.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class MainViewController : UIViewController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let app = Application.instance()

        app.onWindowReady(view)
    }
}

