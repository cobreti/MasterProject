//
// Created by Danny Thibaudeau on 15-07-26.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class RechercheSelectionViewController : UIViewController {

    @IBAction func OnStart(sender: AnyObject) {
//        Application.instance().stories.push( DiagramSelectionStory() )

        Application.instance().actionsBus.send( OpenStoryAction(story: DiagramSelectionStory(), sender: self))
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        addRechercheItem("sample title", question: "test content")

//        let cs = _itemsArea.contentSize
//        _itemsArea.contentSize = CGSize(width: cs.width, height: _nextYPos + 300)
    }


    func addRechercheItem(title: String, question: String) {

        var controller = RechercheItemController(title: title, question: question)


        controller.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        _itemsArea.setTranslatesAutoresizingMaskIntoConstraints(false)

        _itemsArea.addSubview(controller.view)

        _itemsArea.addConstraint(
        NSLayoutConstraint( item: controller.view,
                attribute: NSLayoutAttribute.Width,
                relatedBy: NSLayoutRelation.Equal,
                toItem: _itemsArea,
                attribute: NSLayoutAttribute.Width,
                multiplier: 1.0,
                constant: 0)
        )

        _itemsArea.addConstraint(
        NSLayoutConstraint( item: controller.view,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: nil,
                attribute: NSLayoutAttribute.NotAnAttribute,
                multiplier: 1.0,
                constant: 250)
        )

        if let prevController = _rechercheItems.last {
            _itemsArea.addConstraint(
            NSLayoutConstraint( item: controller.view,
                    attribute: NSLayoutAttribute.Top,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: prevController.view,
                    attribute: NSLayoutAttribute.Bottom,
                    multiplier: 1.0,
                    constant: 0)
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

        let bounds = controller.view.bounds
        controller.view.frame = CGRect(x:0, y:_nextYPos, width:_itemsArea.bounds.width, height: 170)
        controller.view.setNeedsLayout()
        _nextYPos += 170

        _rechercheItems.append(controller)
    }


    @IBOutlet weak var _itemsArea: UIView!

    var _nextYPos : CGFloat = 0
    var _rechercheItems : [RechercheItemController] = []
}
