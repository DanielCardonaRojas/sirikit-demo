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
        self.navigationItem.largeTitleDisplayMode = .always
    }

}

// MARK: - Helpers

extension ListTableViewController {
    private func setupUI() {
        self.title = "TODO List"

        tableView.register(TaskItemTableViewCell.self, forCellReuseIdentifier: Constants.kTaskItemCellIdentifier)

        tableView.tableFooterView = UIView()
        tableView.allowsSelectionDuringEditing = true

        navigationItem.rightBarButtonItem = editBarButton
        navigationItem.leftBarButtonItem = addBarButton

        navigationController?.navigationBar.prefersLargeTitles = true
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
        let viewController = TaskItemViewController()
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - ListView

extension ListTableViewController: ListViewDelegate {
    func didInsertNewTask(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
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

        cell.editingAccessoryType = .disclosureIndicator

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            let viewController = TaskItemViewController(presenter.getTask(at: indexPath.row))
            viewController.delegate =  self
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            presenter.toggleTask(at: indexPath.row)
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        tableView.beginUpdates()
        presenter.deleteTask(at: indexPath.row)
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .delete
        }

        return .none
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView.isEditing {
            return true
        }
        return false
    }
}

// MARK: - TaskItemDelegate

extension ListTableViewController: TaskItemDelegate {
    func didSaveTask(task: Task) {
        DispatchQueue.main.asyncAfter(deadline:  .now() + 0.2) {
            self.tableView.beginUpdates()
            self.presenter.saveTask(task)
        }
    }
}
