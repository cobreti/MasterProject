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

        let bundle = NSBundle.mainBundle();
        
        let fileURL = bundle.URLForResource("NyxTaskExecuterPool_Impl", withExtension: "cpp", subdirectory: "EmbeddedRes/CodeSite/cpp_source/Nyx/NyxBase/Source")
        let filePath = fileURL?.absoluteString
        
        if let url = bundle.URLForResource("index", withExtension: "html", subdirectory: "EmbeddedRes/CodeSite") {
        
            let components = NSURLComponents(string: url.absoluteString!)
            components?.query = "file=\(filePath!)"
        
            let request = NSMutableURLRequest(URL: components!.URL!)
            
            _webView.loadRequest(request)
        }

    }
  
    
    @IBOutlet weak var _webView: UIWebView!
}