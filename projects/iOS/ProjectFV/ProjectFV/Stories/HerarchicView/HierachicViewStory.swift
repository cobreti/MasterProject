//
// Created by Danny Thibaudeau on 15-08-02.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class HierarchicViewStory : Story {

    override var view: UIView! {
        get {
            return _controller.view
        }
    }


    override init() {
        super.init()

        _controller = HierarchicViewController(nibName: "HierarchicView", bundle: nil)
    }

    var _controller : HierarchicViewController!
}
