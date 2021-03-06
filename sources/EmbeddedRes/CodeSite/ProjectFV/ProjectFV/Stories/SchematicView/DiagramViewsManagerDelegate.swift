//
//  DiagramViewsManagerDelegate.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-04.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

protocol DiagramViewsManagerDelegate {
    
    func onDiagramViewActivated(    oldDiagramView: DiagramViewController!,
                                    newDiagramView: DiagramViewController )
    
    func onDiagramViewDeactivated( diagramView: DiagramViewController )
}