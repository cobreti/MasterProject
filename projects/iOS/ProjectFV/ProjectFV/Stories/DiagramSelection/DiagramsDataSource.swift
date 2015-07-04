//
//  DiagramsDataSource.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-06.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class DiagramsDataSource : NSObject, UITableViewDataSource {

    override init() {
        super.init()
        
        _diagramsList = Application.instance().document.diagrams.list()
    }
    
    func getDiagramAtIndex(idx : Int) -> String {
        return _diagramsList[idx]
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _diagramsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        if let reusableCell = tableView.dequeueReusableCellWithIdentifier("DiagramSelection") as? UITableViewCell {
        
            reusableCell.textLabel?.text = _diagramsList[indexPath.indexAtPosition(1)]
            return reusableCell
        }
        
        var cell = UITableViewCell()
        cell.textLabel?.text = _diagramsList[indexPath.indexAtPosition(1)]
        
        return cell
    }
    
    var _diagramsList : [String] = []
}
