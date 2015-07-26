//
// Created by Danny Thibaudeau on 15-07-26.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class RechercheItemController : UIViewController {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(title: String, question: String) {

        _title = title
        _question = question

        super.init(nibName: "RechercheItem", bundle:nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _titleLabel.text = _title
        _questionTextView.text = _question
    }


    var _title : String
    var _question : String

    @IBOutlet weak var _titleLabel: UILabel!
    @IBOutlet weak var _questionTextView: UITextView!
}
