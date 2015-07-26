//
// Created by Danny Thibaudeau on 15-07-26.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class RechercheSelectionStory : Story {

    override var view: UIView! {
        get {
            return _controller.view
        }
    }


    override init() {
        super.init()

        _controller = RechercheSelectionViewController(nibName: "RechercheSelection", bundle: nil)
    }


    var _controller : RechercheSelectionViewController!
}
