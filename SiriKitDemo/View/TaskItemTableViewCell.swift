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
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label

        return label
    }()

    private lazy var doneIcon: UIImageView = {
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

        setupUI()
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

    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(doneIcon)

        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: doneIcon.leftAnchor, constant: -8),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            doneIcon.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            doneIcon.heightAnchor.constraint(equalToConstant: 24),
            doneIcon.widthAnchor.constraint(equalToConstant: 24),
            doneIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)

        ])

        NSLayoutConstraint.activate {
            titleLabel.relativeTo(self, positioned: .centerX())
        }


    }

}
