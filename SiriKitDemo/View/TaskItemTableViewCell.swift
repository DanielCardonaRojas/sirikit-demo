//
//  TaskItemTableViewCell.swift
//  SiriKitDemo
//
//  Created by Andres Rojas on 22/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import UIKit

class TaskItemTableViewCell: UITableViewCell {

    // MARK: - Properties
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label

        return label
    }()

    lazy var doneIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    // MARK: - Properties

    var task: Task? {
        didSet {
            displayInfo()
        }
    }

   // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        selectionStyle = .none

        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    private func displayInfo() {
        guard let task = self.task else { return }

        titleLabel.text = task.title

        doneIcon.image = task.isDone ? UIImage(systemName: "checkmark") : nil
    }

    private func configureLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(doneIcon)

        NSLayoutConstraint.activating([
            titleLabel.relativeTo(contentView, positioned: .centerY() + .left(margin: 8)),
            titleLabel.relativeTo(doneIcon, positioned: .toLeft(spacing: 8)),
            doneIcon.relativeTo(contentView, positioned: .centerY() + .right(margin: 8)),
            doneIcon.constrainedBy(.constantHeight(24) + .constantWidth(24))
        ])
    }

}
