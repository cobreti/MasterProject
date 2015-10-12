//
// Created by Danny Thibaudeau on 15-10-11.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import Shapes

class LongPressGestureHandler : BaseGestureHandler {

    override init(view: DiagramView, portal: DiagramPortal) {
        super.init(view: view, portal: portal)

        let longPressRecognizer = UILongPressGestureRecognizer()
        longPressRecognizer.minimumPressDuration = 1.0
        longPressRecognizer.addTarget(self, action:"onLongPress:")
        self.view.addGestureRecognizer(longPressRecognizer)
    }


    func onLongPress(sender: UILongPressGestureRecognizer) {

        if !enabled {
            return
        }

        if let _ = view.diagram {
            let ptInView = sender.locationInView(view)

            let diagPt = portal.pointFromViewToPortal(Point(x: ptInView.x, y: ptInView.y))

            let actionBus = Application.instance().actionsBus

            switch sender.state {

                case UIGestureRecognizerState.Began:
                    actionBus.send( LongPressAction(pt: diagPt, state: .Began, sender: self))
                    break
                case UIGestureRecognizerState.Ended:
                    actionBus.send( LongPressAction(pt: diagPt, state: .Ended, sender: self))
                    break
                case UIGestureRecognizerState.Cancelled:
                    actionBus.send( LongPressAction(pt: diagPt, state: .Cancelled, sender: self))
                    break
                default:
                    break
            }
        }
    }
}

