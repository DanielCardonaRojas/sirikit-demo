//
//  TaskListView.swift
//  SiriKitDemo
//
//  Created by Daniel Cardona Rojas on 5/02/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import UIKit

protocol TaskListViewDelegate: class {
    func taskListView(_ listView: TaskListView, didInvokeAction action: TaskListView.Action)
}

@IBDesignable
class TaskListView: UIView {
    weak var delegate: TaskListViewDelegate?

    enum Action {
        case edit, done, add
    }
    // MARK: - UI Components

    lazy var editBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEditOrDone))
    lazy var doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapEditOrDone))
    lazy var addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddBarButton))

    lazy var navigationBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.barStyle = .default
        bar.prefersLargeTitles = true
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.setItems([self.navigationItem], animated: false)
        return bar
    }()

    lazy var tableView: UITableView = {
        let tbl = UITableView()
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.tableFooterView = UIView()
        tbl.allowsSelectionDuringEditing = true
        return tbl
    }()

    lazy var navigationItem: UINavigationItem = {
        let item = UINavigationItem(title: "TODO List")
        item.largeTitleDisplayMode = .always
        item.rightBarButtonItem = self.editBarButton
        item.leftBarButtonItem = self.addBarButton
        return item
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    func configureView() {
        configureLayout()
        configureStyles()
    }

    func configureLayout() {
        addSubview(tableView)
        addSubview(navigationBar)
        NSLayoutConstraint.activate {
            navigationBar.relativeTo(tableView, positioned: .above() + .centerX())
            navigationBar.relativeTo(self, positioned: .safeTop() + .width())
            tableView.relativeTo(self, positioned: .width() + .safeBottom() + .centerX())
        }
    }

    func configureStyles() {
        self.backgroundColor = .white

    }


    private func toggleEditOrDone() {
        tableView.isEditing.toggle()
        if tableView.isEditing {
            navigationItem.rightBarButtonItem = doneBarButton
        } else {
            navigationItem.rightBarButtonItem = editBarButton
        }
    }

    // MARK: Actions
    @objc private func didTapEditOrDone() {
        toggleEditOrDone()
        let action: Action = tableView.isEditing ? .edit : .done
        delegate?.taskListView(self, didInvokeAction: action)
    }

    @objc private func didTapAddBarButton() {
        delegate?.taskListView(self, didInvokeAction: .add)

    }

    override func prepareForInterfaceBuilder() {
        configureStyles()
    }

}
