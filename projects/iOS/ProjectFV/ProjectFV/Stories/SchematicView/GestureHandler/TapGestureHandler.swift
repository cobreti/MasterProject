//
//  TapGestureHandler.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-31.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import Shapes
import DiagramElements

class TapGestureHandler : BaseGestureHandler {
    
    override init(view: DiagramView, portal: DiagramPortal, delegate: GestureHandlerDelegate!) {
        
        super.init(view: view, portal: portal, delegate: delegate)
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: "onTap:")
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func onTap( sender : UITapGestureRecognizer ) {
        
        if !enabled {
            return
        }
        
        switch sender.state {
            case UIGestureRecognizerState.Ended:
                if let diagram = view.diagram {
                    let ptInView = sender.locationInView(view)
                    
                    let diagPt = portal.pointFromViewToPortal(Point(x: ptInView.x, y: ptInView.y))

                    let primitives = diagram.primitivesFromPt(diagPt)
                    
                    if primitives.isEmpty {
                        diagram.selection.clear()
                    }
                    else {
                        for item in primitives {
//                            layer.selection.add(item)
                            
                            if let  model = view.diagramDocument?.models.get(item.modelId),
                                    filePath = model.filePath,
                                    rootPath = view.diagramDocument?.filesPathRoot {
                                    
                                let app = Application.instance()
                                
                                app.stories.push( FileViewStory(file: rootPath + filePath) )
                            
//                                debugPrintln("file path for item : '\(model.filePath)' with root being '\(_view.diagramDocument?.filesPathRoot)'")
                            }
                        }
                    }

//                    _view.setNeedsDisplay()
                }
            default:
                break
        }
    }
}