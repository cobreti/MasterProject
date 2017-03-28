//
// Created by Danny Thibaudeau on 15-07-16.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class DiagramHistoryThumbnailViewController : UIViewController {

    var diagramController: DiagramViewController {
        get {
            return _diagramController
        }
    }

    init(diagramController : DiagramViewController) {

        _diagramController = diagramController

        super.init(nibName: "DiagramHistoryThumbnailView", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _diagramPlaceholder.addSubview(_diagramController.view)
        _diagramController.resetView()
        _diagramController.viewDrawingMode = .thumbnail
        _diagramController.view.isUserInteractionEnabled = false

        _diagramNameLabel.text = _diagramController.diagram?.name
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        _diagramController.view.frame = view.bounds
    }

    @IBAction func onTap(_ sender: AnyObject) {

        Application.instance().actionsBus.send( HistoryDiagramSelectedAction(controller: _diagramController, sender: self) )
    }

    var _diagramController : DiagramViewController
    
    @IBOutlet weak var _diagramNameLabel: UILabel!
    @IBOutlet weak var _diagramPlaceholder: UIView!
}

