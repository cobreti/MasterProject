//
// Created by Danny Thibaudeau on 15-07-19.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class QuestionController : UIViewController, UITableViewDelegate, UITableViewDataSource {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    init(question: Question) {

        _question = question

        super.init(nibName: "Question", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _questionLabel.text = _question.question

        _answerChoices?.dataSource = self
        _answerChoices?.delegate = self
        _otherField?.hidden = true
    }

//    func writeAnswer() {
//
//        if let  q = _questionLabel.text,
//        a = _answerTextView.text {
//            Application.instance().actionsBus.send(
//                WriteQuestionAnswerAction(question: q, answer: a, sender: self)
//            )
//        }
//    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _question.answerCount
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        debugPrint("index at path = \(indexPath)")

        let answer = _question.get(indexPath.indexAtPosition(1))

        if let reusableCell = tableView.dequeueReusableCellWithIdentifier("DiagramSelection") {

            reusableCell.textLabel?.text = answer.text
            if let selection = _selectedIndex where indexPath == selection {
                reusableCell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            return reusableCell
        }

        let cell = UITableViewCell()
        cell.textLabel?.text = answer.text
        if let selection = _selectedIndex where indexPath == selection {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark

            _otherField.hidden = !answer.useOtherField
        }

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        _selectedIndex = indexPath

        _answerChoices.reloadData()
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

    }


    @IBOutlet weak var _otherField: UITextView!
    @IBOutlet weak var _answerChoices: UITableView!
    @IBOutlet weak var _questionLabel: UILabel!

    var _question: Question
    var _selectedIndex: NSIndexPath!
}
