//
// Created by Danny Thibaudeau on 15-08-02.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

@objc
class HierarchicViewController : UIViewController, KOTreeViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        _kotreeViewController.delegate = self
        _kotreeViewController.invalidate()
    }

    public func listItemsAtPath(path: String) -> NSMutableArray {

        var ret : NSMutableArray = NSMutableArray()

        return ret
    }


    @IBOutlet var _kotreeViewController: KOTreeViewController!
}
