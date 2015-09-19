//
// Created by Danny Thibaudeau on 2015-09-12.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class StoriesBoardController : UIViewController {

    func setStoryView(view: UIView) {

        if let container = _storyViewContainer {
            _storyViewContainer.addSubview(view)
            view.frame = _storyViewContainer.bounds
        }
    }

    func setModalStoryView(view: UIView) {

        if let wnd = _storyViewContainer.window {
           wnd.addSubview(view)
            view.frame = wnd.bounds
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setVersionLabel()
    }

    func setVersionLabel() {

        if let  dict = NSBundle.mainBundle().infoDictionary,
                version = dict["CFBundleShortVersionString"] as? String,
                build = dict[kCFBundleVersionKey as String] as? String {

            _versionLabel.text = "v\(version).\(build)"
        }
    }

    func enableBackButton(enabled: Bool) {

        _backButton.hidden = !enabled
    }

    func setStoryTB(tbView : UIView!) {

        for obj in _storyTBArea.subviews {
            if let v = obj as? UIView {
                v.removeFromSuperview()
            }
        }

        if let v = tbView {
            _storyTBArea.addSubview(tbView)
            tbView.frame = _storyTBArea.bounds
            tbView.setNeedsLayout()
            tbView.setNeedsDisplay()
        }
    }

    @IBAction func onBack(sender: AnyObject) {

        let app = Application.instance()

        app.stories.closeCurrentStory()
    }
    
    @IBOutlet weak var _storyTBArea: UIView!
    @IBOutlet weak var _backButton: UIButton!
    @IBOutlet weak var _storyViewContainer: UIView!
    @IBOutlet weak var _versionLabel: UILabel!
}

