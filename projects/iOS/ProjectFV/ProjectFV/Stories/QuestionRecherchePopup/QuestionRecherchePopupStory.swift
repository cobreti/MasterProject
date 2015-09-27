//
// Created by Danny Thibaudeau on 15-09-27.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class QuestionRecherchePopupStory : Story {

    override var type: StoryType {
        get {
            return StoryType.Modal
        }
    }

    override var view: UIView! {
        get {
            return _controller.view
        }
    }

    override init() {
        super.init()

        _controller = QuestionRecherchePopupViewController(nibName: "QuestionRecherchePopup", bundle: nil)
    }


    var _controller : QuestionRecherchePopupViewController!
}
