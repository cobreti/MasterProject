//
// Created by Danny Thibaudeau on 15-09-29.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class PresentationPageStory : Story {

    override var view: UIView! {
        get {
            return _controller.view
        }
    }


    override init() {

        super.init()

        _controller = PresentationPageViewController(nibName: "PresentationPage", bundle: nil)
    }


    var _controller : PresentationPageViewController!
}
