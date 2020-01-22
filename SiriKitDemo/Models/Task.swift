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
}
