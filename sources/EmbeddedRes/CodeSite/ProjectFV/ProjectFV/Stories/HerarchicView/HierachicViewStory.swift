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

    override func onAction(action: Action) {

        switch action.id {

            case .FileView:
                if let fva = action as? FileViewAction {
                    Application.instance().stories.push( FileViewStory(file: fva.file) )
                }

            default:
                break
        }
    }


    var _controller : HierarchicViewController!
}
