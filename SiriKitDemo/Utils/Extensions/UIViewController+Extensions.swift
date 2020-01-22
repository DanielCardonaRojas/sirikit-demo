//
//  UIViewController+Extensions.swift
//  SiriKitDemo
//
//  Created by Andres Rojas on 22/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import UIKit

extension UIViewController {

    @objc func dismissKeyboard(recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
