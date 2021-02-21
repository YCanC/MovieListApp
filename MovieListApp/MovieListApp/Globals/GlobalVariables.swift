//
//  GlobalVariables.swift
//  MovieListApp
//
//  Created by yasar.cilingir on 22.02.2021.
//

import Foundation
import UIKit
class GlobalVariables {
    static let posterCache = NSCache<NSNumber, UIImage>()
    static var favouriteMovies = [Movie]()
}
