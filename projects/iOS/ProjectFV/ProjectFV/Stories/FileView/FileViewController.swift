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
    
    var backEventHandler : EventHandler! {
        get {
            return _backEventHandler
        }
        set (value) {
            _backEventHandler = value
        }
    }
 
    init( fileURL : NSURL ) {
        
        _fileURL = fileURL
        
        super.init(nibName: "FileView", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        let bundle = NSBundle.mainBundle();
        
        if let  url = bundle.URLForResource("index", withExtension: "html", subdirectory: "EmbeddedRes/CodeSite") {
        
            let filePath = _fileURL.absoluteString
            let indexPath = url.absoluteString
        
            if let components = NSURLComponents(string: indexPath)  {
                components.query = "file=\(filePath)"
            
                if let componentsURL = components.URL {
                    let request = NSURLRequest(URL: componentsURL)

                    _webView.loadRequest(request)
                }
            }
            
            
        }

    }
  
    @IBAction func onBack(sender: AnyObject) {
        if let handler = _backEventHandler {
            handler(sender: self, args: nil)
        }
    }
    
    @IBOutlet weak var _webView: UIWebView!
    @IBOutlet weak var _backBtn: UIButton!
    
    var _fileURL : NSURL
    var _backEventHandler : EventHandler!
}