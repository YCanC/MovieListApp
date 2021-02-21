//
//  NibLoadedView.swift
//  MovieListApp
//
//  Created by yasar.cilingir on 20.02.2021.
//

import UIKit
protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
