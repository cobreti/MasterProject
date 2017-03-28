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

    var delegate : RechercheItemControllerDelegate! {
        get {
            return _delegate
        }
        set (value) {
            _delegate = value
        }
    }

    var question: SearchQuestion {
        get {
            return _question
        }
    }

    func onSelected() {
        view.backgroundColor = UIColor(red: 174/255.0, green: 198/255.0, blue: 207/255.0, alpha: 1.0)
//        view.backgroundColor = UIColor.lightGrayColor()
        view.setNeedsDisplay()
    }

    func onUnselected() {

        view.backgroundColor = nil
        view.setNeedsDisplay()
    }

    init(question: SearchQuestion) {

        _question = question

        super.init(nibName: "RechercheItem", bundle:nil)
    }

    @IBAction func onTap(_ sender: AnyObject) {

        delegate?.onItemSelected(self)
//        view.backgroundColor = UIColor.lightGrayColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _titleLabel.text = _question.title
        _questionTextView.text = _question.content
        view.layer.cornerRadius = 10.0
    }


    var _delegate : RechercheItemControllerDelegate!
    var _question: SearchQuestion

    @IBOutlet weak var _titleLabel: UILabel!
    @IBOutlet weak var _questionTextView: UITextView!
}
