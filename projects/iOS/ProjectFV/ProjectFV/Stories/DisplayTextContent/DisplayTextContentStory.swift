//
// Created by Danny Thibaudeau on 2016-02-04.
// Copyright (c) 2016 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class DisplayTextContentStory : Story {

    override var view : UIView! {
        get {
            return _controller.view
        }
    }

    init(title: String, content:String) {

        super.init();

        _controller = DisplayTextContentViewController(title: title, content: content);
    }

    var _controller : DisplayTextContentViewController!
}
