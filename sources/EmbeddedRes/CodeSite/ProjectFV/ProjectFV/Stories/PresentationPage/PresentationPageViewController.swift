//
// Created by Danny Thibaudeau on 15-09-29.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class PresentationPageViewController : UIViewController {

    @IBAction func onStart(sender: AnyObject) {
        Application.instance().actionsBus.send( OpenStoryAction(story: QuestionnaireStory(), sender: self))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let bundle = NSBundle.mainBundle();

        if let  url = bundle.URLForResource("index", withExtension: "html", subdirectory: "EmbeddedRes/presentation") {

            let indexPath = url.absoluteString

            if let components = NSURLComponents(string: indexPath)  {

                if let componentsURL = components.URL {
                    let request = NSURLRequest(URL: componentsURL)

                    _webView.loadRequest(request)
                }
            }


        }

    }


    @IBOutlet weak var _webView: UIWebView!
    @IBOutlet weak var _startBtn: UIButton!
}
