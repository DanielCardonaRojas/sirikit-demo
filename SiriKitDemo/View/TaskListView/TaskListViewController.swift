//
//  ListViewController.swift
//  SiriKitDemo
//
//  Created by Andres Rojas on 22/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import UIKit

class TaskListViewController: BaseViewController<TaskListView> {

    // MARK: - Properties

    lazy var presenter = ListPresenter(self)

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(TaskItemTableViewCell.self, forCellReuseIdentifier: Constants.kTaskItemCellIdentifier)
    }
}

// MARK: - TaskListViewDelegate
extension TaskListViewController: TaskListViewDelegate {
    func taskListView(_ listView: TaskListView, didInvokeAction action: TaskListView.Action) {
        if case .add = action {
            let viewController = TaskItemViewController()
            viewController.delegate = self
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}


// MARK: - ListView
extension TaskListViewController: ListViewDelegate {
    func didInsertNewTask(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        customView.tableView.insertRows(at: [indexPath], with: .automatic)
        customView.tableView.endUpdates()
    }

    func didDeleteTask(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        customView.tableView.deleteRows(at: [indexPath], with: .automatic)
        customView.tableView.endUpdates()
    }

    func didUpdateTask(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        customView.tableView.reloadRows(at: [indexPath], with: .automatic)
        customView.tableView.endUpdates()
    }
}

// MARK: - TableView Delegate &  Datasource
extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfTasks
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kTaskItemCellIdentifier, for: indexPath) as? TaskItemTableViewCell else {
            fatalError("Wrong cell")
        }

        cell.task = presenter.getTask(at: indexPath.row)

        cell.editingAccessoryType = .disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            let viewController = TaskItemViewController(presenter.getTask(at: indexPath.row))
            viewController.delegate =  self
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            presenter.toggleTask(at: indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        tableView.beginUpdates()
        presenter.deleteTask(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .delete
        }

        return .none
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView.isEditing {
            return true
        }
        return false
    }
}

// MARK: - TaskItemDelegate 
extension TaskListViewController: TaskItemDelegate {
    func didSaveTask(task: Task) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.customView.tableView.beginUpdates()
            self.presenter.saveTask(task)
        }
    }
}
