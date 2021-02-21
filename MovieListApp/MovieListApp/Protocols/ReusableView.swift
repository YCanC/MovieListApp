//
//  ReusableView.swift
//  MovieListApp
//
//  Created by yasar.cilingir on 20.02.2021.
//

import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
