//
// Created by Danny Thibaudeau on 2015-09-12.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class StoriesBoardController : UIViewController {

    func setStoryView(view: UIView) {

        if let v = _currentStoryView {
            v.removeFromSuperview()
        }

        if let container = _storyViewContainer {
            _storyViewContainer.addSubview(view)
            view.frame = _storyViewContainer.bounds
        }

        _currentStoryView = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setVersionLabel()
    }

    func setVersionLabel() {

        if let  dict = NSBundle.mainBundle().infoDictionary,
                versionKey = NSString(UTF8String: "CFBundleShortVersionString"),
                version = dict[versionKey] as? String,
                build = dict[kCFBundleVersionKey] as? String {

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

    var _currentStoryView : UIView!
}

