//
// Created by Danny Thibaudeau on 2015-09-12.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit

class StoriesBoardController : UIViewController {

    func setStoryView(_ view: UIView) {

        if let _ = _storyViewContainer {
            _storyViewContainer.addSubview(view)
            view.frame = _storyViewContainer.bounds
        }
    }

    func setModalStoryView(_ view: UIView) {

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

        if let  dict = Bundle.main.infoDictionary,
                let version = dict["CFBundleShortVersionString"] as? String,
                let build = dict[kCFBundleVersionKey as String] as? String {

            _versionLabel.text = "v\(version).\(build)"
        }
    }

    func enableBackButton(_ enabled: Bool) {

        _backButton.isHidden = true
    }

    func setStoryTB(_ tbView : UIView!) {

        for v in _storyTBArea.subviews {
            v.removeFromSuperview()
        }

        if let _ = tbView {
            _storyTBArea.addSubview(tbView)
            tbView.frame = _storyTBArea.bounds
            tbView.setNeedsLayout()
            tbView.setNeedsDisplay()
        }
    }

    func removeStoryTB() {

        for v in _storyTBArea.subviews {
            v.removeFromSuperview()
        }
    }

    @IBAction func onBack(_ sender: AnyObject) {

        let app = Application.instance()

        app.stories.closeCurrentStory()
    }
    
    @IBOutlet weak var _storyTBArea: UIView!
    @IBOutlet weak var _backButton: UIButton!
    @IBOutlet weak var _storyViewContainer: UIView!
    @IBOutlet weak var _versionLabel: UILabel!
}

