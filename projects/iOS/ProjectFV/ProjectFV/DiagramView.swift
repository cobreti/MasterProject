//
//  DiagramView.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-15.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class DiagramView : UIView {
    
    override func drawRect(dirtyRect: CGRect) {
        
        var rc : CGRect = CGRect(x: 50, y: 50, width: 200, height: 200)
        var ctx : CGContext = UIGraphicsGetCurrentContext()
        
//        CGContextFillRect(ctx, rc)
        
        if let layer = Application.instance().document.layers.get("DiagramLayout") {
            
            let dd = DiagramDisplay(targetRect: bounds, layer: layer)
            
            dd.display(ctx)
        }
    }
    
}
