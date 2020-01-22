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

    func deleteTask(at index: Int) {
        dataProvider.tasks.remove(at: index)

        view?.didDeleteTask(at: index)
    }

    func toggleTask(at index: Int) {
        dataProvider.tasks[index].isDone.toggle()

        view?.didUpdateTask(at: index)
    }

    func getTask(at index: Int) -> Task {
        return dataProvider.tasks[index]
    }

    func saveTask(_ task: Task) {
        if let index = dataProvider.tasks.firstIndex(where: { $0.id == task.id }) {
            dataProvider.tasks[index].title = task.title
            view?.didUpdateTask(at: index)
        } else {
            let index = dataProvider.tasks.count
            dataProvider.tasks.append(task)

            view?.didInsertNewTask(at: index)
        }
    }
}
