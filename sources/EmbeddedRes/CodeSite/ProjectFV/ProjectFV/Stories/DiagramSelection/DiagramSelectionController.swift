//
//  DiagramSelectionController.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-06.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class DiagramSelectionController : UIViewController, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _dataSource = DiagramsDataSource()
        _tableView.dataSource = _dataSource
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let name = _dataSource.getDiagramAtIndex(indexPath.indexAtPosition(1))
        debugPrintln("diagram selected :\(name)")
        
        Application.instance().actionsBus.send( DiagramSelectedAction(name: name, sender: self) )
        
//        Application.instance().stories.push( SchematicViewStory(diagramName: name) )
    }
 
    var _dataSource : DiagramsDataSource!
    
    @IBOutlet weak var _tableView: UITableView!
}