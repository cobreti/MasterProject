//
//  ActionIdentifier.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-07-11.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

enum ActionIdentifier : String {
    case DiagramSelected            = "Diagram Selected"
    case CloseStory                 = "Close Story"
    case OpenStory                  = "Open Story"
    case PanDiagram                 = "Pan Diagram"
    case ZoomDiagram                = "Zoom Diagram"
    case TapDiagram                 = "Tap Diagram"
    case SelectDiagramElement       = "Select Diagram Element"
    case FileView                   = "File View"
    case ShowDiagram                = "Show Diagram"
    case EnterSubDiagram            = "Enter subdiagram"
    case ExitSubDiagram             = "Exit subdiagram"
    case RecenterDiagram            = "Recenter Diagram"
    case HistoryDiagramSelected     = "History Diagram Selected"
    case WriteQuestionAnswer        = "Write Question & Answer"
    case RechercheItemSelected      = "Item de recherche selectionne"
    case MethodSelection            = "Method Selection"
    case Restart                    = "Restart"
    case TreeItemExpanded           = "Tree Item Expanded"
    case TreeItemCollapsed          = "Tree Item Collapsed"
    case TreeItemSelected           = "Tree Item Selected"
    case ShowQuestionRecherche      = "Show Question Recherche"
}

