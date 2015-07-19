//
// Created by Danny Thibaudeau on 15-07-18.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class QuestionnaireStory : Story {

    override var view: UIView! {
        get {
            return _controller.view
        }
    }


    override init() {

        super.init()

        _controller = QuestionnaireViewController(nibName: "Questionnaire", bundle: nil)
    }

    var _controller : QuestionnaireViewController!
}
