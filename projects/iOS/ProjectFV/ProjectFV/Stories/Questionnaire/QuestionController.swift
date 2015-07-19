//
// Created by Danny Thibaudeau on 15-07-19.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class QuestionController : UIViewController {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    init(question: String) {

        _question = question

        super.init(nibName: "Question", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _answerTextView.layer.borderWidth = 1.0
        _answerTextView.layer.borderColor = UIColor.blackColor().CGColor

        _questionLabel.text = _question
    }


    @IBOutlet weak var _questionLabel: UILabel!
    @IBOutlet weak var _answerTextView: UITextView!

    var _question: String
}
