//
//  Task.swift
//  SiriKitDemo
//
//  Created by Andres Rojas on 22/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import Foundation

struct Task: Codable, Equatable {
    let id: UUID
    var title: String
    var isDone: Bool

    init(title: String) {
        self.id = UUID()
        self.title = title
        self.isDone = false
    }

    mutating func mark(complete: Bool) {
        self.isDone = complete
    }
}
