//
//  TaskItemView.swift
//  SiriKitDemo
//
//  Created by Andres Rojas on 22/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import UIKit
import KeypathAutolayout

@IBDesignable
class TaskItemView: UIView {

    // MARK: - UI Components
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textAlignment = .center

        return label
    }()

    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textView.isEditable = true
        textView.layer.cornerRadius = 5
        textView.font = UIFont.systemFont(ofSize: 16)

        return textView
    }()

    lazy var addButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Add", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK:- Helpers

    private func configureLayout() {
        addSubview(label)
        addSubview(textView)
        addSubview(addButton)

        NSLayoutConstraint.activate {
            label.relativeTo(self, positioned: .safeTop(margin: 8) + .centerX() + .width(constant: -32))
            textView.relativeTo(label, positioned: .below(spacing: 16) + .width() + .centerX())
            textView.constrainedBy(.aspectRatio(0.8))
            addButton.relativeTo(self, positioned: .centerX() + .safeBottom(margin: 16))
            addButton.constrainedBy(.constantWidth(80))
        }
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        textView.text = "Finish work on ..."
    }
}
