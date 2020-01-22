//
//  ListViewController.swift
//  SiriKitDemo
//
//  Created by Andres Rojas on 22/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    // MARK: - UI Components

    private lazy var editBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editList))
    private lazy var doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editList))
    private lazy var addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))

    // MARK: - Properties

    lazy var presenter = ListPresenter(self)

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

// MARK: - Helpers

extension ListTableViewController {
    private func setupUI() {
        self.title = "TODO List"

        tableView.register(TaskItemTableViewCell.self, forCellReuseIdentifier: Constants.kTaskItemCellIdentifier)

        tableView.tableFooterView = UIView()

        navigationItem.rightBarButtonItem = editBarButton
        navigationItem.leftBarButtonItem = addBarButton
    }

    @objc private func editList() {
        tableView.isEditing.toggle()
        if tableView.isEditing {
            navigationItem.rightBarButtonItem = doneBarButton
        } else {
            navigationItem.rightBarButtonItem = editBarButton
        }
    }

    @objc private func addTask() {

    }
}

// MARK: - ListView

extension ListTableViewController: ListViewDelegate {
    func didInsertNewTask(at index: Int) {

    }

    func didDeleteTask(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }

    func didUpdateTask(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}

// MARK: - TableView Delegate &  Datasource

extension ListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfTasks
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kTaskItemCellIdentifier, for: indexPath) as? TaskItemTableViewCell else {
            fatalError("Wrong cell")
        }

        cell.task = presenter.getTask(at: indexPath.row)

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        presenter.markTaskAsDone(at: indexPath.row)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        tableView.beginUpdates()
        presenter.deleteTask(at: indexPath.row)
    }
}
