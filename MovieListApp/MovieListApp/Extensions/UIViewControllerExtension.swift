//
//  UIViewControllerExtension.swift
//  MovieListApp
//
//  Created by yasar.cilingir on 21.02.2021.
//

import UIKit
extension UIViewController {
    
    func enableKeyboardDismissing() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(resignKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func resignKeyboard() {
        self.navigationController?.navigationBar.topItem?.titleView?.resignFirstResponder()
        view.endEditing(true)
    }
}

