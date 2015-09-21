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


    init(question: String) {

        _question = question

        super.init(nibName: "Question", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _questionLabel.text = _question

        _answerChoices?.dataSource = self
        _answerChoices?.delegate = self
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
        return 4
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if let reusableCell = tableView.dequeueReusableCellWithIdentifier("DiagramSelection") {

//            reusableCell.textLabel?.text = _diagramsList[indexPath.indexAtPosition(1)]
            reusableCell.textLabel?.text = "reused row"
            if let selection = _selectedIndex where indexPath == selection {
                reusableCell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            return reusableCell
        }

        var cell = UITableViewCell()
        cell.textLabel?.text = "row"
        if let selection = _selectedIndex where indexPath == selection {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
//        cell.textLabel?.text = _diagramsList[indexPath.indexAtPosition(1)]

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        _selectedIndex = indexPath

        _answerChoices.reloadData()
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

    }


    @IBOutlet weak var _answerChoices: UITableView!
    @IBOutlet weak var _questionLabel: UILabel!

    var _question: String
    var _selectedIndex: NSIndexPath!
}
