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
    
    func getDiagramAtIndex(_ idx : Int) -> String {
        return _diagramsList[idx]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _diagramsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: "DiagramSelection") {
        
            reusableCell.textLabel?.text = _diagramsList[indexPath.item]
            return reusableCell
        }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = _diagramsList[indexPath.item]
        
        return cell
    }
    
    var _diagramsList : [String] = []
}
