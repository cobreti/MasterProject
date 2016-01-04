//
// Created by Danny Thibaudeau on 15-07-26.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import DiagramElements

class RechercheSelectionViewController : UIViewController, RechercheItemControllerDelegate {

    @IBAction func OnStart(sender: AnyObject) {
//        Application.instance().stories.push( DiagramSelectionStory() )

        let app = Application.instance()

        app.actionsBus.send( RechercheItemSelectedAction(question: _selection.question, sender: self))

        if let method = app.method {
            switch method {
                case .Hierarchique:
                    app.actionsBus.send( OpenStoryAction(story: HierarchicViewStory(), sender: self))
                    break
                case .Schematique:
                    onShowSchematicView()
                    break
            }
        }
    }


    func onShowSchematicView() {

        let app = Application.instance()

        if let _ = app.document.diagrams.get("main") {

            let story = SchematicViewStory(diagramName: "main")
            Application.instance().actionsBus.send( OpenStoryAction(story: story, sender: self) )
        }
        else {
            app.actionsBus.send(OpenStoryAction(story: DiagramSelectionStory(), sender: self))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let doc = Application.instance().document
        var questions : [String:SearchQuestion] = [:]

        if let diag = doc.diagrams.get("Recherches") {

            for (_, p) in diag.primitives {

                if let  elm = p as? Element,
                        modelId = elm.modelId,
                        model = doc.models.get(modelId),
                        name = elm.name,
                        plainTextValue = model.plainTextValue {

                    let question = SearchQuestion(title: "", content: plainTextValue);
                    if let fileRef = model.fileReferences.getForParentDiagram(nil) {
                        question.file = fileRef.path
                    }
                    questions[name] = question

//                    addRechercheItem( SearchQuestion(title: name, content: plainTextValue))
                }
            }
        }

        let sortedQuestionKeys = Array(questions.keys).sort(<)

        for name in sortedQuestionKeys {
            if let question = questions[name] {
                addRechercheItem(question)
            }
        }

        _startBtn.enabled = false
    }


    func addRechercheItem( question: SearchQuestion ) {

        let controller = RechercheItemController(question: question)
        controller.delegate = self

//        controller.view.setTranslatesAutoresizingMaskIntoConstraints(false)
//        _itemsArea.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        _itemsArea.translatesAutoresizingMaskIntoConstraints = false

        _itemsArea.addSubview(controller.view)

        _itemsArea.addConstraint(
        NSLayoutConstraint( item: controller.view,
                attribute: NSLayoutAttribute.Right,
                relatedBy: NSLayoutRelation.Equal,
                toItem: _itemsArea,
                attribute: NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: -30)
        )

        _itemsArea.addConstraint(
            NSLayoutConstraint( item: controller.view,
                    attribute: NSLayoutAttribute.Left,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: _itemsArea,
                    attribute: NSLayoutAttribute.Left,
                    multiplier: 1.0,
                    constant: 30)
        )

        _itemsArea.addConstraint(
        NSLayoutConstraint( item: controller.view,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: nil,
                attribute: NSLayoutAttribute.NotAnAttribute,
                multiplier: 1.0,
                constant: 150)
        )

        if let prevController = _rechercheItems.last {
            _itemsArea.addConstraint(
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
            _itemsArea.addConstraint(
            NSLayoutConstraint( item: controller.view,
                    attribute: NSLayoutAttribute.Top,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: _itemsArea,
                    attribute: NSLayoutAttribute.Top,
                    multiplier: 1.0,
                    constant: 0)
            )
        }

//        let bounds = controller.view.bounds
//        controller.view.frame = CGRect(x:0, y:_nextYPos, width:_itemsArea.bounds.width, height: 170)
//        controller.view.setNeedsLayout()
//        _nextYPos += 170

        _rechercheItems.append(controller)
    }


    func onItemSelected(item: RechercheItemController) {

        if item !== _selection {

            _selection?.onUnselected()
            _selection = item
            _selection?.onSelected()
            view.setNeedsDisplay()

            _startBtn.enabled = true
        }
    }


    @IBOutlet weak var _itemsArea: UIView!
    @IBOutlet weak var _startBtn: UIButton!

    var _nextYPos : CGFloat = 0
    var _rechercheItems : [RechercheItemController] = []

    weak var _selection : RechercheItemController!
}
