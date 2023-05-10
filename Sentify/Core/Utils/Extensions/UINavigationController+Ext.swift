//
//  UINavigationController+Ext.swift
//  Sentify
//
//  Created by Bryan on 09/05/23.
//

import UIKit

extension UINavigationController {
  open override func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = nil
  }
}
