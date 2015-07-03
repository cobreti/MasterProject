//
//  GestureHandlerDelegate.swift
//  ProjectFV
//
//  Created by Danny Thibaudeau on 2015-06-25.
//  Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

import Foundation

protocol GestureHandlerDelegate {
    
    func onGestureStarted()
    func onGestureChanged()
    func onGestureEnded()
}