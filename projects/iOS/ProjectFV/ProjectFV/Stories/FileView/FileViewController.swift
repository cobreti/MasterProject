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
 
    init( fileURL : URL ) {
        
        _fileURL = fileURL
        
        super.init(nibName: "FileView", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        let bundle = Bundle.main;
        let app = Application.instance();
        
        if let  url = bundle.url(forResource: "index", withExtension: "html", subdirectory: "EmbeddedRes/CodeSite") {
        
            let filePath = _fileURL.absoluteString
            let indexPath = url.absoluteString
                
            if var  components = URLComponents(string: indexPath)  {

                var queryString = "file=\(filePath)"

//                components.query = "file=\(filePath)"

                if let  question = app.searchQuestion,
                        let questionURL = question.fileURL {

                    if questionURL == _fileURL {
                        _itemFound = true
                        debugPrint("item found")
                        queryString += "&found=true"
                        
                        app.writeToLog("item found")
                    }
                }

                components.query = queryString


                if let componentsURL = components.url {
                    let request = URLRequest(url: componentsURL)

                    _webView.loadRequest(request)
                }
            }
            
            
        }

    }
  
    @IBAction func onBack(_ sender: AnyObject) {
        if _itemFound {
            let app = Application.instance()
            app.executeNextStep()
        }
        else if let handler = _backEventHandler {
            handler(self, nil)
        }
    }
    
    @IBOutlet weak var _webView: UIWebView!
    @IBOutlet weak var _backBtn: UIButton!
    
    var _fileURL : URL
    var _backEventHandler : EventHandler!
    var _itemFound : Bool = false
}
