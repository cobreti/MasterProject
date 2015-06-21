//
//  FileViewController.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-21.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class FileViewController : UIViewController {
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = NSURL(string: "http://www.outlook.com") {
            let request = NSURLRequest(URL: url)
            
            _webView.loadRequest(request)
        }

    }
 
    
    @IBOutlet weak var _webView: UIWebView!
}