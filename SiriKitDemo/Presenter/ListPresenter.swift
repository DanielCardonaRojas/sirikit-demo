//
//  ListPresenter.swift
//  SiriKitDemo
//
//  Created by Andres Rojas on 22/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import Foundation

protocol ListViewDelegate: class {
    func didInsertNewTask(at index: Int)
    func didDeleteTask(at index: Int)
    func didUpdateTask(at index: Int)
}

class ListPresenter {

    // MARK: -- Properties

    private let dataProvider = DataProvider()

    weak var view: ListViewDelegate?

    var numberOfTasks: Int {
        return dataProvider.tasks.count
    }

    // MARK: - Initializer

    init(_ view: ListViewDelegate? = nil) {
        self.view = view
    }

    // MARK: - Helpers

    func addTask(title: String, isDone: Bool = false) {
        let task = Task(title: title, isDone: isDone)
        let index = dataProvider.tasks.count
        dataProvider.tasks.append(task)

        view?.didInsertNewTask(at: index)
    }

    func deleteTask(at index: Int) {
        dataProvider.tasks.remove(at: index)

        view?.didDeleteTask(at: index)
    }

    func markTaskAsDone(at index: Int) {
        dataProvider.tasks[index].isDone.toggle()

        view?.didUpdateTask(at: index)
    }

    func getTask(at index: Int) -> Task {
        return dataProvider.tasks[index]
    }
}
