//
// Created by Danny Thibaudeau on 15-09-27.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class QuestionRecherchePopupViewController : UIViewController {

    var closeEventHandler: EventHandler! {
        get {
            return _closeEventHandler
        }
        set(handler) {
            _closeEventHandler = handler
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let question = Application.instance().searchQuestion {

            _questionTitle?.text = question.title
            _questionContent?.text = question.content
        }
    }

    @IBAction func onClosePopup(sender: AnyObject) {
        _closeEventHandler?(sender: self, args: nil)
    }

    @IBOutlet weak var _questionTitle: UILabel!
    @IBOutlet weak var _questionContent: UITextView!

    var _closeEventHandler : EventHandler!
}
