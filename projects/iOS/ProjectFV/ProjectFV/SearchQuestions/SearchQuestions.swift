//
// Created by Danny Thibaudeau on 15-09-27.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

class SearchQuestions  {

    var count: Int {
        get {
            return _questions.count
        }
    }

    init() {
        
    }
    
    func add(question: SearchQuestion) {
        _questions.append(question)
    }
    
    func get(index: Int) -> SearchQuestion! {
        
        return _questions[index]
    }
    
    func foreach( fct: (question: SearchQuestion) -> Void ) {
        
        for question in _questions {
            fct(question: question)
        }
    }
    

    var _questions: [SearchQuestion] = []
}
