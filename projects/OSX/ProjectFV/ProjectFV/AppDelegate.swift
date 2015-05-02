//
//  AppDelegate.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-04-27.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Cocoa
import DiagramElements
import VpProject

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application

//        var pt : XMLParsingTest = XMLParsingTest()

        var proj = VpProject()


        if let url = NSBundle.mainBundle().URLForResource("ProjectFV",
                                                       withExtension: "xml",
                                                       subdirectory: "EmbeddedRes/diagrams") {
            proj.load(url)
        }

        debugPrintln("project loaded")

    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

