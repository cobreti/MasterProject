//
// Created by Danny Thibaudeau on 2016-02-04.
// Copyright (c) 2016 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class DisplayTextContentViewController  : UIViewController {

    convenience init(title:String, content:String) {
        self.init(nibName: "DisplayTextContent", bundle: nil)

        _titleText = title
        _contentText = content
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _textContent.text = _contentText
        _title.text = _titleText
    }


    @IBAction func onContinue(sender: AnyObject) {
        let app = Application.instance()
        app.executeNextStep()
    }
    
    @IBOutlet weak var _textContent: UITextView!
    @IBOutlet weak var _title: UILabel!

    var _titleText: String!
    var _contentText: String!
}
