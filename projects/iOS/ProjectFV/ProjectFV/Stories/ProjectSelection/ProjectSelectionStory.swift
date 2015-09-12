//
// Created by Danny Thibaudeau on 15-08-14.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class ProjectSelectionStory : Story {

    override var view: UIView {
        get {
            return _controller.view
        }
    }

    override init() {
        super.init()

        _controller = ProjectSelectionViewController(nibName: "ProjectSelection", bundle: nil)
    }

    override func onActivate() {
        super.onActivate()

        _controller.onActivated()
    }


    var _controller : ProjectSelectionViewController!
}
