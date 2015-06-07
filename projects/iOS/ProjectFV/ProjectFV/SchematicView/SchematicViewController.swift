//
//  SchematicViewController.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-06.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import DiagramElements

class SchematicViewController : UIViewController {
    
    var diagramLayer : DiagramLayer! {
        get {
            return _diagramLayer
        }
        set (value) {
            _diagramLayer = value
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        _diagramController = DiagramViewController(nibName: "DiagramView", bundle: nil)
        _diagramController.diagramLayer = diagramLayer
        
        _diagramArea.addSubview(_diagramController.view)
        _diagramController.view.frame = _diagramArea.bounds
    }

    var _diagramLayer : DiagramLayer!
    var _diagramController : DiagramViewController!

    @IBOutlet weak var _controlsArea: UIView!
    @IBOutlet weak var _diagramArea: UIView!
}
