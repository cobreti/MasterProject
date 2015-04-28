//
//  AppDelegate.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-04-27.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application

        var pt : XMLParsingTest = XMLParsingTest()

    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

