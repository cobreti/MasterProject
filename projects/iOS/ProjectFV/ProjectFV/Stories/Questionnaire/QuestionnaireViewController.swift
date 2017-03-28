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

        let education = Question(question: "Éducation")
        education.add( AnswerChoice(key: "college", text: "Diplôme collégial") )
        education.add( AnswerChoice(key: "BACC", text: "Baccalauréat") )
        education.add( AnswerChoice(key: "Master", text: "Maîtrise") )
        education.add( AnswerChoice(key: "Phd", text: "Doctorat") )
        education.add( AnswerChoice(key: "autre", text: "Autre", useOtherField: true) )
        addQuestion(education)

        let umlExp = Question(question: "Connaissance de UML")
        umlExp.add( AnswerChoice(key: "none", text: "Aucune"))
        umlExp.add( AnswerChoice(key: "beginner", text: "Débutant"))
        umlExp.add( AnswerChoice(key: "intermediate", text: "Intermédiaire"))
        umlExp.add( AnswerChoice(key: "advanced", text: "Avancé"))
        addQuestion(umlExp)

        let umlUsage = Question(question: "Utilisation de UML")
        umlUsage.add( AnswerChoice(key: "never", text: "Jamais") )
        umlUsage.add( AnswerChoice(key: "rarely", text: "Occasionnellement") )
        umlUsage.add( AnswerChoice(key: "frequently", text: "Fréquemment"))
        addQuestion(umlUsage)

        let devExp = Question(question: "Expérience en développement logiciel")
        devExp.add( AnswerChoice(key: "beginner", text: "Débutant (moins de 5 ans)"))
        devExp.add( AnswerChoice(key: "Intermédiaire", text: "Intermédiaire (5 à 15 ans)"))
        devExp.add( AnswerChoice(key: "Advanced", text: "Avancé (plus de 15 ans)"))
        addQuestion(devExp)

        let touchDevice = Question(question: "Possédez ou utilisez vous régulièrement un appareil à écran tactile")
        touchDevice.add( AnswerChoice(key: "oui", text: "oui"))
        touchDevice.add( AnswerChoice(key: "non", text: "non"))
        addQuestion(touchDevice)

//        addQuestion("Expérience")


//        addQuestion("Connaissane de UML")

//        let doc = Application.instance().document
//        _diagram = _document.diagrams.get("Questionnaire")
//
//        if let diag = _diagram {
//
//            for (_, p) in diag.primitives {
//
//                if let elm = p as? Element {
//                    debugPrint("element with name : \(elm.name)")
//                    addQuestion(elm.name)
//                }
//            }
//        }
//
        let cs = _scrollView.contentSize
        _scrollView.contentSize = CGSize(width: cs.width, height: _nextYPos + 400)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    @IBAction func onContinue(_ sender: AnyObject) {

        for question in _questions {
            question.writeAnswer()
        }

        Application.instance().actionsBus.send( OpenStoryAction(story: MethodSelectionStory(), sender: self))
//        Application.instance().stories.push( RechercheSelectionStory() )
    }

    func addQuestion(_ question: Question) {

        let controller = QuestionController(question: question)

        controller.view.translatesAutoresizingMaskIntoConstraints = false
//        controller.view.setTranslatesAutoresizingMaskIntoConstraints(false)
//        _scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        _scrollView.translatesAutoresizingMaskIntoConstraints = false;

        _scrollView.addSubview(controller.view)


        _scrollView.addConstraint(
        NSLayoutConstraint( item: controller.view,
                attribute: NSLayoutAttribute.left,
                relatedBy: NSLayoutRelation.equal,
                toItem: _scrollView,
                attribute: NSLayoutAttribute.left,
                multiplier: 1.0,
                constant: 20)
        )

        _scrollView.addConstraint(
        NSLayoutConstraint( item: controller.view,
                attribute: NSLayoutAttribute.width,
                relatedBy: NSLayoutRelation.equal,
                toItem: _scrollView,
                attribute: NSLayoutAttribute.width,
                multiplier: 1.0,
                constant: -40)
        )

        _scrollView.addConstraint(
            NSLayoutConstraint( item: controller.view,
                    attribute: NSLayoutAttribute.height,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: nil,
                    attribute: NSLayoutAttribute.notAnAttribute,
                    multiplier: 1.0,
                    constant: 250)
        )

        if let prevController = _questions.last {
            _scrollView.addConstraint(
                NSLayoutConstraint( item: controller.view,
                        attribute: NSLayoutAttribute.top,
                        relatedBy: NSLayoutRelation.equal,
                        toItem: prevController.view,
                        attribute: NSLayoutAttribute.bottom,
                        multiplier: 1.0,
                        constant: 20)
            )
        }
        else {
            _scrollView.addConstraint(
                NSLayoutConstraint( item: controller.view,
                        attribute: NSLayoutAttribute.top,
                        relatedBy: NSLayoutRelation.equal,
                        toItem: _scrollView,
                        attribute: NSLayoutAttribute.top,
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
