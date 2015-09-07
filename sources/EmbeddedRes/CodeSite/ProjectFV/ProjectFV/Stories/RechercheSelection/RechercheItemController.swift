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

    var itemTitle: String {
        return _title
    }

    var itemQuestion: String {
        return _question
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

    init(title: String, question: String) {

        _title = title
        _question = question

        super.init(nibName: "RechercheItem", bundle:nil)
    }

    @IBAction func onTap(sender: AnyObject) {

        delegate?.onItemSelected(self)
//        view.backgroundColor = UIColor.lightGrayColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _titleLabel.text = _title
        _questionTextView.text = _question
        view.layer.cornerRadius = 10.0
    }


    var _title : String
    var _question : String
    var _delegate : RechercheItemControllerDelegate!

    @IBOutlet weak var _titleLabel: UILabel!
    @IBOutlet weak var _questionTextView: UITextView!
}
