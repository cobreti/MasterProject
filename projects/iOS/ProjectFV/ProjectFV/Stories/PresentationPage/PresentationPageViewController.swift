//
// Created by Danny Thibaudeau on 15-09-29.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class PresentationPageViewController : UIViewController {

    @IBAction func onStart(_ sender: AnyObject) {
        Application.instance().actionsBus.send( OpenStoryAction(story: QuestionnaireStory(), sender: self))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let bundle = Bundle.main;

        if let  url = bundle.url(forResource: "index", withExtension: "html", subdirectory: "EmbeddedRes/presentation") {

            let indexPath = url.absoluteString

            if let components = URLComponents(string: indexPath)  {

                if let componentsURL = components.url {
                    let request = URLRequest(url: componentsURL)

                    _webView.loadRequest(request)
                }
            }


        }

    }


    @IBOutlet weak var _webView: UIWebView!
    @IBOutlet weak var _startBtn: UIButton!
}
