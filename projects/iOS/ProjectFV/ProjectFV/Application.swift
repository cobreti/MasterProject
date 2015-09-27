//
//  Application.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-05-15.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation
import UIKit
import DiagramElements
import VpProject

var g_app : Application!

class Application : ActionListener {
    
    class func instance() -> Application {
        
        if let app = g_app {
            return app
        }
        
        g_app = Application()
        return g_app!
    }

    var method : MethodType! {
        get {
            return _method
        }
    }
    
    var stories : StoriesMgr {
        get {
            return _storiesMgr!
        }
    }
    
    var actionsBus : ActionsBus {
        get {
            return _actionsBus!
        }
    }
    
    var document : DiagramElements.Document {
        get {
            return _document
        }
    }
    
    var searchQuestion : SearchQuestion! {
        get {
            return _searchQuestion
        }
    }
    
    func loadDiagrams() {
    
        let proj = VpProject( document: _document )
        
        if let url = NSBundle.mainBundle().URLForResource(  "diagrams",
                                                            withExtension: "xml",
                                                            subdirectory: "EmbeddedRes/diagrams/ProjectFV") {
            proj.load(url)
            _document.filesPathRoot = "EmbeddedRes/CodeSite/ProjectFV/"
        }
    }
    
    func finishedLaunching() {
    
        _actionsBus = ActionsBus()
        _storiesMgr = StoriesMgr()
        
        _actionsBus.listeners.add(_storiesMgr)
        _actionsBus.listeners.add(self)
    }

    func onWindowReady(viewContainer: UIView) {

        _storiesMgr.onWindowReady(viewContainer)

        actionsBus.send( OpenStoryAction(story: QuestionnaireStory(), sender: self))
    }

    func onAction(action: Action) {

        switch action.id {
            case .MethodSelection:
                if let msa = action as? MethodSelectionAction {
                    _method = msa.method
                    actionsBus.send( OpenStoryAction(story: RechercheSelectionStory(), sender: self) )
                }
            
            case .RechercheItemSelected:
                if let risa = action as? RechercheItemSelectedAction {
                    _searchQuestion = risa.question
                }

            default:
                break
        }
    }

    var _mainWindow : UIWindow!
    var _document : DiagramElements.Document = DiagramElements.Document()
    var _mainViewController : UIViewController!
    var _storiesMgr : StoriesMgr!
    var _actionsBus : ActionsBus!
    var _method : MethodType!
    var _searchQuestion : SearchQuestion!
}

