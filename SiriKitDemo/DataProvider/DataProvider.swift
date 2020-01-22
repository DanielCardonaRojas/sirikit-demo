//
//  DataProvider.swift
//  SiriKitDemo
//
//  Created by Andres Rojas on 22/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import Foundation

let defaultTasks: [Task] = [
    Task(id: UUID(), title: "Read SwiftUI Documentation 📚", isDone: false),
    Task(id: UUID(), title: "Watch WWDC19 Keynote 🎉", isDone: true),
]

final class DataProvider {
    @UserDefaultsWrapper(key: Constants.kTaskDefaultKey, defaultValue: defaultTasks)
    var tasks: [Task] 
}
