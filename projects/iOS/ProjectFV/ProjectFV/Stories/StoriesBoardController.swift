//
// Created by Danny Thibaudeau on 2015-09-12.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class StoriesBoardController : UIViewController {

    func setStoryView(view: UIView) {

        if let v = _currentStoryView {
            v.removeFromSuperview()
        }

        if let container = _storyViewContainer {
            _storyViewContainer.addSubview(view)
            view.frame = _storyViewContainer.bounds
        }

        _currentStoryView = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _versionLabel.text = "v1.0.1"
    }


    @IBOutlet weak var _storyViewContainer: UIView!
    @IBOutlet weak var _versionLabel: UILabel!

    var _currentStoryView : UIView!
}

