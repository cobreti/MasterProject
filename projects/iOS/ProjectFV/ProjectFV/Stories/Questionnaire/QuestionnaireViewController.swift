//
// Created by Danny Thibaudeau on 15-07-18.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import DiagramElements

class QuestionnaireViewController : UIViewController {

    convenience init(document: DiagramElements.Document) {

        self.init(nibName: "Questionnaire", bundle: nil)

        _document = document
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        let doc = Application.instance().document
        _diagram = _document.diagrams.get("Questionnaire")

        if let diag = _diagram {

            for (_, p) in diag.primitives {

                if let elm = p as? Element {
                    debugPrint("element with name : \(elm.name)")
                    addQuestion(elm.name)
                }
            }
        }

        let cs = _scrollView.contentSize
        _scrollView.contentSize = CGSize(width: cs.width, height: _nextYPos + 300)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }

    @IBAction func onContinue(sender: AnyObject) {

        for question in _questions {
            question.writeAnswer()
        }

        Application.instance().actionsBus.send( OpenStoryAction(story: ProjectSelectionStory(), sender: self))
//        Application.instance().stories.push( RechercheSelectionStory() )
    }

    func addQuestion(title : String) {

        let controller = QuestionController(question: title)

        controller.view.translatesAutoresizingMaskIntoConstraints = false
//        controller.view.setTranslatesAutoresizingMaskIntoConstraints(false)
//        _scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        _scrollView.translatesAutoresizingMaskIntoConstraints = false;

        _scrollView.addSubview(controller.view)


        _scrollView.addConstraint(
        NSLayoutConstraint( item: controller.view,
                attribute: NSLayoutAttribute.Left,
                relatedBy: NSLayoutRelation.Equal,
                toItem: _scrollView,
                attribute: NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: 20)
        )

        _scrollView.addConstraint(
        NSLayoutConstraint( item: controller.view,
                attribute: NSLayoutAttribute.Width,
                relatedBy: NSLayoutRelation.Equal,
                toItem: _scrollView,
                attribute: NSLayoutAttribute.Width,
                multiplier: 1.0,
                constant: -40)
        )

        _scrollView.addConstraint(
            NSLayoutConstraint( item: controller.view,
                    attribute: NSLayoutAttribute.Height,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: nil,
                    attribute: NSLayoutAttribute.NotAnAttribute,
                    multiplier: 1.0,
                    constant: 250)
        )

        if let prevController = _questions.last {
            _scrollView.addConstraint(
                NSLayoutConstraint( item: controller.view,
                        attribute: NSLayoutAttribute.Top,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: prevController.view,
                        attribute: NSLayoutAttribute.Bottom,
                        multiplier: 1.0,
                        constant: 20)
            )
        }
        else {
            _scrollView.addConstraint(
                NSLayoutConstraint( item: controller.view,
                        attribute: NSLayoutAttribute.Top,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: _scrollView,
                        attribute: NSLayoutAttribute.Top,
                        multiplier: 1.0,
                        constant: 0)
            )
        }

        _ = controller.view.bounds
        controller.view.frame = CGRect(x:0, y:_nextYPos, width:_scrollView.bounds.width, height: 170)
        controller.view.setNeedsLayout()
        _nextYPos += 170

        _questions.append(controller)
    }

    var _diagram : Diagram!
    var _document : DiagramElements.Document!
    
    @IBOutlet weak var _scrollView: UIScrollView!

    var _questions : [QuestionController] = []
    var _nextYPos : CGFloat = 0
}
