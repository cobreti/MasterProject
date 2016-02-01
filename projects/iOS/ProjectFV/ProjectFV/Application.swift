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

//        actionsBus.send( OpenStoryAction(story: QuestionnaireStory(), sender: self))
        actionsBus.send( OpenStoryAction(story: PresentationPageStory(), sender: self))
    }

    func onAction(action: Action) {

        switch action.id {
            case .MethodSelection:
                if let msa = action as? MethodSelectionAction {
                    _method = msa.method
                    feedSteps();
//                    actionsBus.send( OpenStoryAction(story: RechercheSelectionStory(), sender: self) )
                }
            
//            case .RechercheItemSelected:
//                if let risa = action as? RechercheItemSelectedAction {
//                    _searchQuestion = risa.question
//                }

            default:
                break
        }
    }

    func executeNextStep() {

        if ( _steps.count > 0 ) {
            let topStep = _steps.removeFirst();
            topStep.execute()
        }
    }

    func feedSteps() {

        // load ProjectFV diagrams first
        _steps.append( Step(fct: { () -> Void in
            let doc = Application.instance().document

            doc.clear()

            let proj = VpProject( document: doc )

            if let url = NSBundle.mainBundle().URLForResource(  "diagrams",
                    withExtension: "xml",
                    subdirectory: "EmbeddedRes/diagrams/ProjectFV") {
                proj.load(url)
                doc.filesPathRoot = "EmbeddedRes/CodeSite/ProjectFV/"
                doc.projectName = "ProjectFV"
                self.executeNextStep();
            }
        }))


        // load search question for ProjectFV
        _steps.append( Step( fct: { () -> Void in

            let doc = self.document
            var questions : [String:SearchQuestion] = [:]

            if let diag = doc.diagrams.get("Recherches") {

                for (_, p) in diag.primitives {

                    if let  elm = p as? Element,
                            modelId = elm.modelId,
                            model = doc.models.get(modelId),
                            name = elm.name,
                            plainTextValue = model.plainTextValue {

                        let question = SearchQuestion(title: "", content: plainTextValue);
                        if let fileRef = model.fileReferences.getForParentDiagram(nil) {
                            question.file = fileRef.path
                        }

                        self._searchQuestion = question
                        self.startSearchView();
                    }
                }
            }
        }));

        // clear stories and load Nyx project
        _steps.append( Step(fct: { () -> Void in

            self._storiesMgr.removeAllStories()

            let doc = self.document

            doc.clear()

            let proj = VpProject( document: doc )

            if let url = NSBundle.mainBundle().URLForResource(  "diagrams",
                    withExtension: "xml",
                    subdirectory: "EmbeddedRes/diagrams/Nyx") {
                proj.load(url)
                doc.filesPathRoot = "EmbeddedRes/CodeSite/Nyx/"
                doc.projectName = "Nyx"
            }

            self.executeNextStep();
        }))

        // load search question for Nyx
        _steps.append( Step( fct: { () -> Void in

            let doc = self.document
            var questions : [String:SearchQuestion] = [:]

            if let diag = doc.diagrams.get("Recherches") {

                for (_, p) in diag.primitives {

                    if let  elm = p as? Element,
                    modelId = elm.modelId,
                    model = doc.models.get(modelId),
                    name = elm.name,
                    plainTextValue = model.plainTextValue {

                        let question = SearchQuestion(title: "", content: plainTextValue);
                        if let fileRef = model.fileReferences.getForParentDiagram(nil) {
                            question.file = fileRef.path
                        }

                        self._searchQuestions.append(question)
                    }
                }
            }

            self.executeNextStep()
        }));

        _steps.append( Step( fct: { () -> Void in

            let question = self._searchQuestions.removeFirst()
            self._searchQuestion = question
            self.startSearchView();
        }))

        _steps.append( Step( fct: { () -> Void in

            self._storiesMgr.removeAllStories()
            let question = self._searchQuestions.removeFirst()
            self._searchQuestion = question
            self.startSearchView();
        }))

        _steps.append( Step( fct: { () -> Void in

            self._storiesMgr.removeAllStories()
            let question = self._searchQuestions.removeFirst()
            self._searchQuestion = question
            self.startSearchView();
        }))

        _steps.append( Step( fct: { () -> Void in

            self._storiesMgr.removeAllStories()
        }))

        executeNextStep();
    }

    func startSearchView() {

        if let method = method {
            switch method {
            case .Hierarchique:
                actionsBus.send( OpenStoryAction(story: HierarchicViewStory(), sender: self))
                break
            case .Schematique:
                onShowSchematicView()
                break
            }
        }
    }

    func onShowSchematicView() {

        if let _ = document.diagrams.get("main") {

            let story = SchematicViewStory(diagramName: "main")
            actionsBus.send( OpenStoryAction(story: story, sender: self) )
        }
        else {
            actionsBus.send(OpenStoryAction(story: DiagramSelectionStory(), sender: self))
        }
    }


    var _mainWindow : UIWindow!
    var _document : DiagramElements.Document = DiagramElements.Document()
    var _mainViewController : UIViewController!
    var _storiesMgr : StoriesMgr!
    var _actionsBus : ActionsBus!
    var _method : MethodType!
    var _searchQuestion : SearchQuestion!
    var _searchQuestions : [SearchQuestion] = [];
    var _steps : [Step] = []
}

